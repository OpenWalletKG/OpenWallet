class AddColumnToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :type_money, :string
  end
end
