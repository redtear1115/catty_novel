# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: Secret.omniauth.symbolize_keys.keys

  has_many :identities, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :novels, through: :collections

  def self.find_or_create_identity_with_auth_info(raw_auth_info)
    indentity_attrs = Identity.to_attrs(raw_auth_info)
    user = find_or_initialize_by(email: indentity_attrs[:email])
    user.fast_setup(indentity_attrs[:name]) if user.new_record?
    user.update_identity(indentity_attrs)
  end

  def update_identity(indentity_attrs)
    identity = identities.find_or_initialize_by(provider: indentity_attrs[:provider], uid: indentity_attrs[:uid])
    identity.assign_attributes(indentity_attrs)
    identity.save!
    identity.user
  end

  def add_to_collection(novel)
    return if novel.nil?
    return if novel.last_sync_url.nil?
    return if collections.include?(novel.collections.find_by(user_id: id))
    collections.create(novel: novel)
    collections
  end

  def fast_setup(new_name)
    random_password = SecureRandom.urlsafe_base64
    self.name = new_name
    self.password = random_password
    self.password_confirmation = random_password
    save!
  end
end
