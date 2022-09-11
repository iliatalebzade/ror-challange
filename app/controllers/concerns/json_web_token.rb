require "jwt"
module JsonWebToken
  extend ActiveSupport::Concern
  SECRET_KEY = ENV["JWT_SECRET_KEY"]

  def jwt_encode(user_email, expiration_date)
    payload = { email: user_email, exp: expiration_date.to_i }
    # generating the token
    return JWT.encode(payload, SECRET_KEY)
  end

  def jwt_decode(token)
    return JWT.decode(token, SECRET_KEY)[0]
  end
end