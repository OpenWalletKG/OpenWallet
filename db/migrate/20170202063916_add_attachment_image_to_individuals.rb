class AddAttachmentImageToIndividuals < ActiveRecord::Migration
  def self.up
    change_table :individuals do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :individuals, :image
  end
end
