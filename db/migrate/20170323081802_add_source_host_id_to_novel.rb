class AddSourceHostIdToNovel < ActiveRecord::Migration[5.0]
  def change
    add_column :novels, :source_host_id, :integer
    add_column :novels, :status, :string
  end
end
