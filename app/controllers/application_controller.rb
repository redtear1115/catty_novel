class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, if: :actions_skipped

  private

  def actions_skipped
    skipped_map = {
      'sessions' => ['create', 'destroy']
    }
    return false if skipped_map[controller_name].nil?
    return skipped_map[controller_name].include?(action_name)
  end
end
