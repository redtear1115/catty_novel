class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  skip_before_filter :verify_authenticity_token, if: -> { controller_name == 'sessions' && ['create', 'destroy'].include?(action_name) }
end
