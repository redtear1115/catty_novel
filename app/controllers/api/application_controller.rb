class Api::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  protected

  def success_page(data)
    {
      status: :ok,
      json: {
        status: 200,
        message: :ok,
        data: data
      }
    }
  end

  def fail_page(message)
    {
      status: :fail,
      json: {
        status: 500,
        message: message,
      }
    }
  end

end
