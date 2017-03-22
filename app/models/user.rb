class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :collections
  has_many :novels, through: :collections
  
  def add_to_collection(novel)
    self.collections.create(novel: novel)
    return self.novels
  end
end
