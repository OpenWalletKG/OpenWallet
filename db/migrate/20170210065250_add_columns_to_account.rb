class AddColumnsToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :title, :string
    add_column :accounts, :type_money, :string
  end
end
