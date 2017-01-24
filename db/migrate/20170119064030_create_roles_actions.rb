class CreateRolesActions < ActiveRecord::Migration[5.0]
  def change
    create_table :roles_actions do |t|
      t.references :role, foreign_key: true
      t.references :action, foreign_key: true

      t.timestamps
    end
  end
end
