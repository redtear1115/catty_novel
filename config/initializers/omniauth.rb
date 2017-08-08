# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  facebook = Secret.omniauth.facebook
  provider :facebook, facebook.app_id, facebook.app_secret, facebook.app_options

  google_oauth2 = Secret.omniauth.google_oauth2
  provider :google_oauth2, google_oauth2.app_id, google_oauth2.app_secret, google_oauth2.app_options

  twitter = Secret.omniauth.twitter
  provider :twitter, twitter.app_id, twitter.app_secret, twitter.app_options

  linkedin = Secret.omniauth.linkedin
  provider :linkedin, linkedin.app_id, linkedin.app_secret, linkedin.app_options

  on_failure { |env| OmniauthsController.action(:failure).call(env) }
end
