class CreateNovels < ActiveRecord::Migration[5.0]
  def change
    create_table :novels do |t|
      t.string :name
      t.string :author
      t.string :catgory
      t.string :source_url
      t.timestamps
    end
  end
end
