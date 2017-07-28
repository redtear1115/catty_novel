class OmniauthsController < Devise::OmniauthCallbacksController
  before_action :verify_auth_info!, except: [:failure, :auth_info]
  before_action :verify_email!, except: [:failure, :auth_info]
  before_action :omniauth_core, except: [:failure, :auth_info]

  include ApiReturnPageHelper

  def facebook; end
  def google_oauth2; end
  def twitter; end
  def linkedin; end

  def failure
    redirect_to account_profile_path, { alert: '認證失敗' }
  end

  def auth_info
    os = OmniauthService.new(omniauth_params[:provider], omniauth_params[:omniauth_token], omniauth_params[:omniauth_secret])
    auth_info = os.get_info
    if auth_info.nil?
      render forbidden_page('認證失敗')
    else
      render ok_page(auth_info)
    end
  end

  private

  def omniauth_params
    params.permit(:format, :provider, :omniauth_token, :omniauth_secret)
  end

  def verify_auth_info!
    @auth_info = request.env['omniauth.auth']
    redirect_to account_profile_path, { alert: '認證失敗' } and return if @auth_info.nil?
  end

  def verify_email!
    @email = @auth_info['info']['email']
    redirect_to account_profile_path, { alert: '缺少信箱，認證失敗' } and return if @email.nil?
  end

  def omniauth_core
    if signed_in?
      binding_identity
    else
      user = User.find_or_create_identity_with_auth_info(@auth_info)
      sign_in(:user, user)
      redirect_to account_profile_path, { notice: '連結成功' }
    end
  end

  def binding_identity
    if current_user.email == @email
      user = current_user.find_or_create_identity_with_auth_info(@auth_info)
      redirect_to account_profile_path, { notice: "成功連結至 #{user.email}" }
    else
      message = "第三方信箱 #{@email} 與 #{current_user.email} 不一致，連結失敗"
      redirect_to account_profile_path, { alert: message }
    end
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
