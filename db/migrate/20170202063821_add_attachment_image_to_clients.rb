class AddAttachmentImageToClients < ActiveRecord::Migration
  def self.up
    change_table :clients do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :clients, :image
  end
end
