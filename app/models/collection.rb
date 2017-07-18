class Collection < ApplicationRecord

  belongs_to :user
  belongs_to :novel

  def last_read_chapter_number
    chapter = Chapter.find_by(id: self.last_read_chapter)
    return 1 if chapter.nil?
    chapter.number
  end

  def simple
    {
      novel_id: novel_id,
      last_read_chapter: last_read_chapter
    }
  end

end
