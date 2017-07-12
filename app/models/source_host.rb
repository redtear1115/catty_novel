class SourceHost < ApplicationRecord

  has_many :novels

  def valid_url?(novel_url)
    regex_string =~ novel_url ? true : false
  end

  private

  def regex_string
    allowed_hash = {
      'https://ck101.com/forum-237-1.html' => /https:\/\/ck101\.com\/thread-\d*-1-1\.html/
    }
    allowed_hash[self.url]
  end

end
