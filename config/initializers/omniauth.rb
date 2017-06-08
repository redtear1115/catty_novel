Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Secret.omniauth.facebook.app_id, Secret.omniauth.facebook.app_secret
  on_failure { |env| OmniauthsController.action(:failure).call(env) }
end
