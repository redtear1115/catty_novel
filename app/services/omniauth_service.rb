# frozen_string_literal: true

class OmniauthService
  def initialize(provider, access_token, oauth_token_secret = nil)
    @provider = provider
    @access_token = access_token
    @oauth_token_secret = oauth_token_secret
  end

  def get_info
    case provider
    when 'facebook'
      get_info_from_facebook
    when 'google_oauth2'
      get_info_from_google_oauth2
    when 'twitter'
      get_info_from_twitter
    when 'linkedin'
      get_info_from_linkedin
    end
  end

  def get_info_from_facebook
    uri = URI("#{facebook_api_uri}?access_token=#{access_token}&fields=name,id,email")
    response = Net::HTTP.get(uri)
    hash = Oj.load(response)
    return nil if hash['error'].present?
    { id: hash['id'], email: hash['email'], name: hash['name'] }
  rescue StandardError => e
    Rails.logger.error("omniauth error:#{e}")
    nil
  end

  def get_info_from_google_oauth2
    uri = URI("#{google_oauth2_api_uri}?access_token=#{access_token}&key=#{Secret.omniauth.google_oauth2.app_id}")
    response = Net::HTTP.get(uri)
    hash = Oj.load(response)
    return nil if hash['error'].present?
    { id: hash['id'], email: hash['emails'].first['value'], name: hash['displayName'] }
  rescue StandardError => e
    Rails.logger.error("omniauth error:#{e}")
    nil
  end

  def get_info_from_twitter
    token_hash = { oauth_token: access_token, oauth_token_secret: oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(twitter_consumer, token_hash)
    response = access_token.get("#{twitter_api_uri}?include_email=true")
    hash = Oj.load(response.body)
    return nil if hash['errors'].present?
    { id: hash['id'], email: hash['email'], name: hash['name'] }
  rescue StandardError => e
    Rails.logger.error("omniauth error:#{e}")
    nil
  end

  def get_info_from_linkedin
    uri = URI("#{linkedin_api_uri}?oauth2_access_token=#{access_token}&format=json")
    response = Net::HTTP.get(uri)
    hash = Oj.load(response)
    return nil if hash['status'].present?
    { id: hash['id'], email: hash['emailAddress'], name: hash['formattedName'] }
  rescue StandardError => e
    Rails.logger.error("omniauth error:#{e}")
    nil
  end

  private

  attr_reader :provider

  attr_reader :access_token

  attr_reader :oauth_token_secret

  def facebook_api_uri
    'https://graph.facebook.com/me'
  end

  def google_oauth2_api_uri
    'https://www.googleapis.com/plus/v1/people/me'
  end

  def twitter_api_uri
    'https://api.twitter.com/1.1/account/verify_credentials.json'
  end

  def twitter_consumer
    OAuth::Consumer.new(
      Secret.omniauth.twitter.app_id,
      Secret.omniauth.twitter.app_secret,
      site: 'https://api.twitter.com', scheme: :header
    )
  end

  def linkedin_api_uri
    'https://api.linkedin.com/v1/people/~:(id,email-address,formatted-name)'
  end
end
