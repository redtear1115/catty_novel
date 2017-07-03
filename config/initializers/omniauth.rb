Rails.application.config.middleware.use OmniAuth::Builder do
  facebook = Secret.omniauth.facebook
  provider :facebook, facebook.app_id, facebook.app_secret, facebook.app_options
  on_failure { |env| OmniauthsController.action(:failure).call(env) }
end
