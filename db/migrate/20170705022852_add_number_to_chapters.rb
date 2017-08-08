# frozen_string_literal: true

class AddNumberToChapters < ActiveRecord::Migration[5.1]
  def change
    add_column :chapters, :number, :integer, null: false, default: 0
    add_index :chapters, %i[novel_id number], unique: true
  end
end
