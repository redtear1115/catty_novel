class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: Secret.omniauth.symbolize_keys.keys

  has_many :identities, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :novels, through: :collections

  def self.create_with_omniauth(provider, uid, info)
    user = find_or_initialize_by(email: info['email'])
    if user.new_record?
      random_password = SecureRandom.urlsafe_base64
      user.name = info['name']
      user.password = random_password
      user.password_confirmation = random_password
      user.save!
    end
    Identity.create(user: user, provider: provider, uid: uid)
  end

  def add_to_collection(novel)
    return if novel.nil?
    return if novel.last_sync_url.nil?
    return if self.collections.include?(novel.collections.find_by(user_id: self.id))
    self.collections.create(novel: novel)
    return self.novels
  end

end
