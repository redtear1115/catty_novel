class AddExternalIdToChapter < ActiveRecord::Migration[5.0]
  def change
    add_column :chapters, :external_id, :string
  end
end
