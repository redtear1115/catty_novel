class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :actions_skipped

  private

  def actions_skipped
    skipped_map = {
      'sessions' => ['create', 'destroy'],
      'omniauth_callbacks' => :all
    }
    return false if skipped_map[controller_name].nil?
    return true if skipped_map[controller_name] == :all
    return skipped_map[controller_name].include?(action_name)
  end
end
