class AddFolderIdToArchives < ActiveRecord::Migration
  def change
    add_column :archives, :folder_id, :integer
    add_index :archives, :folder_id
  end
end
