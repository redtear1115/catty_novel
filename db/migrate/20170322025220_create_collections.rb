# frozen_string_literal: true

class CreateCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.integer :user_id
      t.integer :novel_id
      t.timestamps
    end
  end
end
