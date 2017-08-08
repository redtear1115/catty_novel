# frozen_string_literal: true

class AddIsPublishToNovel < ActiveRecord::Migration[5.1]
  def change
    add_column :novels, :is_publish, :boolean, default: true
  end
end
