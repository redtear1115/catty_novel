class OmniauthsController < Devise::OmniauthCallbacksController
  before_action :check_auth
  before_action :check_email
  before_action :check_signed_in
  before_action :omniauth_core

  def facebook; end
  def google_oauth2; end
  def twitter; end
  def linkedin; end

  private

  def check_auth
    # 認證失敗
    head 500 and return if request.env['omniauth.auth'].nil?
    @auth = request.env['omniauth.auth']
  end

  def check_email
    # 無法取得 email
    head 400 and return if auth['info'].nil? || auth['info']['email'].nil?
  end

  def check_signed_in
    @identity = Identity.find_or_initialize_by(key_columns)
    return unless signed_in?

    if @identity.user == current_user
      redirect_to account_path, { notice: 'Already linked that account!' } and return
    else
      @identity.user = current_user
      @identity.save!
      redirect_to account_path, { notice: 'Successfully linked that account!' } and return
    end

  end

  def auth
    @auth
  end

  def key_columns
    @key_columns ||= { provider: auth['provider'], uid: auth['uid'] }
  end

  def omniauth_core
    if @identity.user.present?
      sign_in(:user, @identity.user)
      redirect_to root_path, { notice: 'Signed in!' } and return
    else
      if auth['provider'] == 'linkedin'
        auth['info']['name'] = auth['extra']['raw_info']['formattedName']
      end
      # 直接建立帳號給使用者
      @identity = User.create_with_omniauth(auth['provider'], auth['uid'], auth['info'])
      sign_in(:user, @identity.user)
      # mail password to user
      redirect_to root_path, { notice: 'User Created & Signed in!' } and return
    end
    redirect_to root_path, { notice: 'Unknow Problem' } and return
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
