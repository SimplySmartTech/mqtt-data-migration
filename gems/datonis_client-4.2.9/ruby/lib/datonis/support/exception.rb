module DatonisException
  
  class DatonisException::BaseError < StandardError
    attr_accessor :errors
  end
  class DatonisException::ConnectionError < DatonisException::BaseError; end
  class DatonisException::ServerError < DatonisException::BaseError; end  
  class DatonisException::BadRequestError < DatonisException::BaseError; end
  class DatonisException::NotFoundError < DatonisException::BaseError; end
  class DatonisException::NoMethodError < DatonisException::BaseError; end
  class DatonisException::SessionExpired < DatonisException::BaseError; end
  class DatonisException::NoAccess < DatonisException::BaseError; end

  def self.handle_response(response)
    case response.code
    when '401'
      raise DatonisException::ConnectionError, "Login failed. Incorrect email/password or authentication token expired" 
    when '404'
      raise DatonisException::NotFoundError, "The object you are looking for does not exist!"
    when '500'
      raise DatonisException::ServerError, "Internal server error. Please contact Altizon support."
    when '400'
      raise DatonisException::BadRequestError, response.body 
    when '403'
      raise DatonisException::NoAccess, "User is not allowed to perform specified operation."
    end
  end

end
