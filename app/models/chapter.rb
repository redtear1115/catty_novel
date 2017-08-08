# frozen_string_literal: true

class Chapter < ApplicationRecord
  belongs_to :novel

  def neighbors
    prev_number = number <= novel.min_chapter_number ? 'end_page' : number - 1
    next_number = number >= novel.max_chapter_number ? 'end_page' : number + 1
    { prev: prev_number, curr: number, next: next_number }
  end
end
