# frozen_string_literal: true

class Identity < ApplicationRecord
  belongs_to :user

  def self.read_auth_info(auth_info)
    {
      provider: auth_info['provider'],
      uid: auth_info['uid'],
      email: auth_info['info']['email'],
      name: auth_info['info']['name'] || auth_info['extra']['raw_info']['formattedName'],
      token: auth_info['credentials']['token'],
      secret: auth_info['credentials']['secret']
    }
  end
end
