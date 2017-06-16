class Api::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!
  before_action :set_default_page

  def set_default_page
    @page_to_render = fail_page('Unknow error')
  end

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

  def not_found_page(message)
    {
      status: :not_found,
      json: {
        status: 403,
        message: message,
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
