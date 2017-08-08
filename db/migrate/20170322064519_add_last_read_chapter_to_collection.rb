# frozen_string_literal: true

class AddLastReadChapterToCollection < ActiveRecord::Migration[5.0]
  def change
    add_column :collections, :last_read_chapter, :integer
  end
end
