class OmniauthsController < Devise::OmniauthCallbacksController
  before_action :check_auth


  def facebook
    redirect_to root_url, omniauth_core
  end

  def google_oauth2
    redirect_to root_url, omniauth_core
  end

  private

  def check_auth
    head 500 and return if request.env['omniauth.auth'].nil?
    @auth = request.env['omniauth.auth']
  end

  def auth
    @auth
  end

  def auth_key
    @auth_key ||= { provider: @auth['provider'], uid: @auth['uid'] }
  end

  def omniauth_core
    # Find an identity here
    @identity = Identity.find_or_initialize_by(auth_key)

    if signed_in?
      if @identity.user == current_user
        return { notice: 'Already linked that account!' }
      else
        @identity.user = current_user
        @identity.save!
        return { notice: 'Successfully linked that account!' }
      end
    else
      if @identity.user.present?
        sign_in(:user, @identity.user)
        return { notice: 'Signed in!' }
      else
        @identity = User.create_with_omniauth(auth['provider'], auth['uid'], auth['info'])
        sign_in(:user, @identity.user)
        # mail password to user
        return { notice: 'User Created & Signed in!' }
      end
    end

    return { notice: 'Unknow Problem' }
  end

end

# class Devise::OmniauthCallbacksController < DeviseController
#   prepend_before_action { request.env['devise.skip_timeout'] = true }
#
#   def passthru
#     render status: 404, plain: 'Not found. Authentication passthru.'
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
#     request.respond_to?(:get_header) ? request.get_header('omniauth.error.strategy') : request.env['omniauth.error.strategy']
#   end
#
#   def failure_message
#     exception = request.respond_to?(:get_header) ? request.get_header('omniauth.error') : request.env['omniauth.error']
#     error   = exception.error_reason if exception.respond_to?(:error_reason)
#     error ||= exception.error        if exception.respond_to?(:error)
#     error ||= (request.respond_to?(:get_header) ? request.get_header('omniauth.error.type') : request.env['omniauth.error.type']).to_s
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
