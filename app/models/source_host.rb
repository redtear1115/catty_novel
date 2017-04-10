class SourceHost < ApplicationRecord
  has_many :novels
  
  def valid_url?(url)
    return true
  end
end
