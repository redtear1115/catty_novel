class RemoveIndexChapterExternalId < ActiveRecord::Migration[5.1]
  def change
    remove_index :chapters, :external_id
  end
end
