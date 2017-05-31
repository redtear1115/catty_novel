class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collections
  has_many :novels, through: :collections

  def add_to_collection(novel)
    return nil if novel.nil?
    return nil if novel.last_sync_url.nil?
    return nil if self.collections.include?(novel.collections.find_by(user_id: self.id))
    self.collections.create(novel: novel)
    return self.novels
  end

end
