class AddOkpoToCorporates < ActiveRecord::Migration[5.0]
  def change
    add_column :corporates, :okpo, :string
  end
end
