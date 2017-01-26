RAM_DRIVE_MOUNTING_POINT = "/tmp/ramdrive"
DRIVE_SPACE_IN_MB = 300

require 'yaml'
exit if Gem.win_platform?

#--------------------------------------- RamDrive Class ---------------------------------------

class RamDrive
  attr_accessor :mount_point, :drive_space

  def initialize(mount_point, drive_space)
    @mount_point = mount_point
    @drive_space = drive_space
  end

  def is_mounted?
    !%x( mountpoint -d -q #{ @mount_point } ).empty?
  end

  def mount
    if Dir.exists?( @mount_point )
      %x( sudo rmdir #{ @mount_point } )
    end

    %x( sudo mkdir -p #{ @mount_point } )
    puts "Создана папка #{ @mount_point } для монтирования"

    %x( sudo mount -t ramfs -o size=#{ @drive_space.to_s }M ramfs #{ @mount_point } )
    puts "Смонтрован RAM drive на #{ @mount_point }"

    %x( sudo chmod 777 #{ @mount_point } )
    puts "Установлены права для папки #{ @mount_point }"

    user = %x( whoami ).strip
    %x( sudo chown #{ user }:#{ user }  #{ @mount_point } )

  end

  def umount
    %x( sudo umount #{ @mount_point } )
    puts "RAM drive на #{ @mount_point } размонтирован"

    %x( sudo rmdir #{ @mount_point } )
    puts "Папка #{ @mount_point } удалена"
  end

  def remount
    umount
    mount
  end
end

#--------------------------------------- MemoryDB class ---------------------------------------

class MemoryDB
  attr_accessor :adapter
  def initialize(ram_drive_db_path)
    @ram_db_path = ram_drive_db_path
    db_config = Rails.application.config.database_configuration
    case db_config["development"]["adapter"]
      when "postgresql"
        @adapter = Postgres.new(ram_drive_db_path)
      else
        puts "Неизвестный адаптер"
        exit
    end
  end

  def init
    @adapter.init
  end

  def destroy
    @adapter.destroy
  end

end

#--------------------------------------- Postgres Class ---------------------------------------

class Postgres

  def initialize(ram_db_path)
    @ram_db_path = ram_db_path.to_s
    @pg_user_and_group = "postgres:postgres"
    @pg_lockfile_directory = "/var/run/postgresql"

    if %x( pg_config | grep BINDIR ).strip == ""
      puts "Postgres не установлен!"
      exit
    end
    @pg_ctl = Pathname( %x( pg_config | grep BINDIR ).split('=')[1].strip ) + "pg_ctl"

    if %x( systemctl status postgresql | grep SUCCESS ).strip == ""
      puts "Postgres не запущен!"
      exit
    end

    @pg_config_file = %x(sudo -u postgres psql -c "show config_file;" | grep postgresql.conf).strip
    @pg_backup_config_file = @pg_config_file + ".backup"
  end

  def init

    if Dir.exists?( @ram_db_path ) && File.exists?( @pg_backup_config_file )
      puts "БД в RAM Drive уже инициализирована"
      exit
    end

    puts "Проверка/Создание и установка прав #{ @pg_lockfile_directory }"
    %x( sudo mkdir -p #{ @pg_lockfile_directory } )
    %x( sudo chown -R #{ @pg_user_and_group } #{ @pg_lockfile_directory } )

    puts "Создание папки для БД в RAM Drive: #{ @ram_db_path }"
    %x( mkdir -p #{ @ram_db_path } )

    puts "Установка прав #{ @pg_user_and_group} для папки #{ @ram_db_path }"
    %x( sudo chown -R #{ @pg_user_and_group } #{ @ram_db_path } )

    puts "Остановка сервера Postgres"
    %x( sudo systemctl stop postgresql )

    puts "Инициализация БД в RAM Drive #{ @ram_db_path }"
    %x( sudo -u postgres #{ @pg_ctl } initdb -D #{ @ram_db_path } )

    puts "Сохранение файла конфигурации #{ @pg_config_file }: #{ @pg_backup_config_file }"
    %x( sudo -u postgres cp #{ @pg_config_file } #{ @pg_backup_config_file } )

    puts "Дозапись файла конфигурации ( data_directory = '#{ @ram_db_path }' )"
    %x( sudo chmod 666 #{ @pg_config_file } )
    system "echo \"data_directory = '#{ @ram_db_path }'\" >> #{ @pg_config_file }"

    puts "Запуск сервера Postgres"
    %x( systemctl start postgresql )

    user = Rails.application.config.database_configuration[Rails.env]["username"]
    pass = Rails.application.config.database_configuration[Rails.env]["password"]
    exit if user.nil? || pass.nil?

    puts "Создание пользователя #{ user } с паролем #{ pass }."
    %x( sudo -u postgres psql -c "CREATE USER #{ user } WITH SUPERUSER CREATEDB PASSWORD '#{ pass }';" )

  end

  def destroy
    puts "Остановка сервера Postgres"
    %x( sudo systemctl stop postgresql )

    puts "Удаление папки БД из RAM Drive: #{ @ram_db_path }"
    %x( sudo -u postgres rm -R #{ @ram_db_path } )

    puts "Восстановление файла конфигурации #{ @pg_backup_config_file }: #{ @pg_config_file }"
    %x( sudo -u postgres mv #{ @pg_backup_config_file } #{ @pg_config_file } )

    puts "Запуск сервера Postgres"
    %x( sudo systemctl start postgresql )
  end
end

#--------------------------------------- ramdrive: namespace ---------------------------------------

namespace :ramdrive do

  desc 'Запуск RAM Drive в оперативной памяти'
  task start: :environment do
    ram_drive = RamDrive.new(RAM_DRIVE_MOUNTING_POINT, DRIVE_SPACE_IN_MB)
    if ram_drive.is_mounted?
      puts "RAM Drive уже смонтирован!"
      exit
    end
    ram_drive.mount
  end


  desc 'Удаление RAM Drive из оперативной памяти'
  task stop: :environment do
    ram_drive = RamDrive.new(RAM_DRIVE_MOUNTING_POINT, DRIVE_SPACE_IN_MB)
    ram_drive.umount
  end

  desc 'Перемонтирование RAM Drive'
  task restart: :environment do
    ram_drive = RamDrive.new(RAM_DRIVE_MOUNTING_POINT, DRIVE_SPACE_IN_MB)
    puts "Запуск перемонтирования"
    ram_drive.remount
  end

  desc 'Статус RAM Drive'
  task status: :environment do
    puts "RAM Drive: " + ( Dir.exists?(RAM_DRIVE_MOUNTING_POINT) ? "РАБОТАЕТ" : "ОТКЛЮЧЕН" )
  end

end

#--------------------------------------- db:ram namespace ---------------------------------------

namespace :db do

  namespace :ram do

    desc 'Перенаправление файла БД в RAM drive'
    task init: :environment do
      memory_db = MemoryDB.new(Pathname(RAM_DRIVE_MOUNTING_POINT) + "db")
      memory_db.init
    end

    desc 'Перенаправление файла БД по умолчанию'
    task destroy: :environment do
      memory_db = MemoryDB.new(Pathname(RAM_DRIVE_MOUNTING_POINT) + "db")
      memory_db.destroy
    end

    desc 'Статус БД в RAM Drive'
    task status: :environment do
      puts "БД в RAM Drive: " + ( Dir.exists?( Pathname(RAM_DRIVE_MOUNTING_POINT) + "db" ) ? "РАБОТАЕТ" : "ОТКЛЮЧЕН" )
    end

  end
end

