# frozen_string_literal: true

class AddUniqueIndexToNovel < ActiveRecord::Migration[5.1]
  def change
    add_index :novels, :source_url, unique: true
    add_index :chapters, :external_id, unique: true
    add_index :source_hosts, :url, unique: true
  end
end
