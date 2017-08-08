# frozen_string_literal: true

class CreateChapters < ActiveRecord::Migration[5.0]
  def change
    create_table :chapters do |t|
      t.integer :novel_id
      t.text :content
      t.timestamps
    end
  end
end
