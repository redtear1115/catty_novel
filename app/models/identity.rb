class Identity < ApplicationRecord
  belongs_to :user

  def update_from_omniauth(omniauth)
    self.provider = omniauth['provider']
    self.uid = omniauth['uid']
    self.email = omniauth['info']['email']
    self.name = omniauth['info']['name'] || omniauth['extra']['raw_info']['formattedName']
    self.token = omniauth['credentials']['token']
    self.secret = omniauth['credentials']['secret']
    self.save!
  end
end
