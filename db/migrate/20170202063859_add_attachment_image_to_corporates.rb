class AddAttachmentImageToCorporates < ActiveRecord::Migration
  def self.up
    change_table :corporates do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :corporates, :image
  end
end
