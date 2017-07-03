class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: Secret.omniauth.symbolize_keys.keys

  has_many :identities, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :novels, through: :collections

  def self.create_with_omniauth(provider, uid, info)
    password = SecureRandom.urlsafe_base64
    user = self.create(name: info['name'], email: info['email'], password: password, password_confirmation: password)
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
