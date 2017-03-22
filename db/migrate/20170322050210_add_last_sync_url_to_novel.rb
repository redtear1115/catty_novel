class AddLastSyncUrlToNovel < ActiveRecord::Migration[5.0]
  def change
    add_column :novels, :last_sync_url, :string
  end
end
