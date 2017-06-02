class Collection < ApplicationRecord

  belongs_to :user
  belongs_to :novel

  def last_read_chapter_idx
    chapter = Chapter.find_by(id: self.last_read_chapter)
    return 0 if chapter.nil?
    self.novel.chapter_index.index(chapter.external_id)
  end

end
