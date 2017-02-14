class AddFullNameToCorporates < ActiveRecord::Migration[5.0]
  def change
    add_column :corporates, :full_name, :string
  end
end
