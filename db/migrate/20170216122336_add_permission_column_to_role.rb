class AddPermissionColumnToRole < ActiveRecord::Migration[5.0]
  def change
    add_column :roles, :permission, :integer
  end
end
