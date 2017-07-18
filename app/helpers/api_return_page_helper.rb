module ApiReturnPageHelper

  def ok_page(data)
    {
      status: :ok,
      json: {
        code: 200,
        message: :ok,
        data: data
      }
    }
  end

  def bad_request_page(message)
    {
      status: :bad_request,
      json: {
        code: 400,
        message: message,
      }
    }
  end

  def unauthorized_page(message)
    {
      status: :unauthorized,
      json: {
        code: 401,
        message: message,
      }
    }
  end

  def forbidden_page(message)
    {
      status: :forbidden,
      json: {
        code: 403,
        message: message,
      }
    }
  end

  def not_found_page(message)
    {
      status: :not_found,
      json: {
        code: 403,
        message: message,
      }
    }
  end

  def internal_server_error_page(message)
    {
      status: :internal_server_error,
      json: {
        code: 500,
        message: message,
      }
    }
  end

end
