class OmniauthsController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env['omniauth.auth']

    key_columns = { provider: auth['provider'], uid: auth['uid'] }
    # Find an identity here
    @identity = Identity.find_by(key_columns)
    @identity = Identity.new(key_columns) if @identity.nil?

    if signed_in?
      if @identity.user == current_user
        redirect_to root_url, notice: "Already linked that account!"
      else
        @identity.user = current_user
        @identity.save!
        redirect_to root_url, notice: "Successfully linked that account!"
      end
    else
      if @identity.user.present?
        sign_in(:user, @identity.user)
        redirect_to root_url, notice: "Signed in!"
      else
        @identity = User.create_with_omniauth(auth['provider'], auth['uid'], auth['info'])
        sign_in(:user, @identity.user)
        # mail password to user
        redirect_to root_url, notice: "User Created & Signed in!"
      end
    end
  end
end

# class Devise::OmniauthCallbacksController < DeviseController
#   prepend_before_action { request.env["devise.skip_timeout"] = true }
#
#   def passthru
#     render status: 404, plain: "Not found. Authentication passthru."
#   end
#
#   def failure
#     set_flash_message :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
#     redirect_to after_omniauth_failure_path_for(resource_name)
#   end
#
#   protected
#
#   def failed_strategy
#     request.respond_to?(:get_header) ? request.get_header("omniauth.error.strategy") : request.env["omniauth.error.strategy"]
#   end
#
#   def failure_message
#     exception = request.respond_to?(:get_header) ? request.get_header("omniauth.error") : request.env["omniauth.error"]
#     error   = exception.error_reason if exception.respond_to?(:error_reason)
#     error ||= exception.error        if exception.respond_to?(:error)
#     error ||= (request.respond_to?(:get_header) ? request.get_header("omniauth.error.type") : request.env["omniauth.error.type"]).to_s
#     error.to_s.humanize if error
#   end
#
#   def after_omniauth_failure_path_for(scope)
#     new_session_path(scope)
#   end
#
#   def translation_scope
#     'devise.omniauth_callbacks'
#   end
