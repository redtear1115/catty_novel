# frozen_string_literal: true

class Api::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!
end
