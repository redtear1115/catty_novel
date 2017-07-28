class Chapter < ApplicationRecord

  belongs_to :novel

  def neighbors
    prev_number = self.number <= self.novel.min_chapter_number ? 'end_page' : self.number - 1
    next_number = self.number >= self.novel.max_chapter_number ? 'end_page' : self.number + 1
    { prev: prev_number, curr: self.number, next: next_number }
  end

end
