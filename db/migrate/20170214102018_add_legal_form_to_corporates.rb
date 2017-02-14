class AddLegalFormToCorporates < ActiveRecord::Migration[5.0]
  def change
    add_column :corporates, :legal_form, :string
  end
end
