class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: Secret.omniauth.symbolize_keys.keys

  has_many :identities, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :novels, through: :collections

  def self.find_or_create_identity_with_auth_info(raw_auth_info)
    auth_info = Identity.read_auth_info(raw_auth_info)
    user = find_or_initialize_by(email: auth_info[:email])
    if user.new_record?
      random_password = SecureRandom.urlsafe_base64
      user.name = auth_info[:name]
      user.password = random_password
      user.password_confirmation = random_password
      user.save!
    end
    user.find_or_create_identity_with_auth_info(raw_auth_info)
  end

  def find_or_create_identity_with_auth_info(raw_auth_info)
    auth_info = Identity.read_auth_info(raw_auth_info)
    identity = self.identities.find_or_initialize_by(provider: auth_info[:provider], uid: auth_info[:uid])
    identity.assign_attributes(auth_info)
    identity.save!
    identity.user
  end

  def add_to_collection(novel)
    return if novel.nil?
    return if novel.last_sync_url.nil?
    return if self.collections.include?(novel.collections.find_by(user_id: self.id))
    self.collections.create(novel: novel)
    return self.novels
  end


end
