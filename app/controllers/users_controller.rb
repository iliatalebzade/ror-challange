class UsersController < ApplicationController
  def register
    # reciving the given and filtered data
    recived_data = registration_params

    # checking if email is already in use
    email_is_taken = User.find_by(email: recived_data[:email])

    # - checks if the email is available 
    if email_is_taken
      render json: { message: 'Email id already exist' }
    else
      User.create(recived_data)
      render json: { message: 'OK' }
    end
  end

  def login
    # reciving the given and filtered data
    recived_data = login_params
    # the secret_key used to generate JWT_TOKEN
    signature = ENV["JWT_SECRET_KEY"]
    
    # check if there's a registered user with the provided email address
    if User.find_by(email: recived_data[:email])
      # generating an expiratoin date
      expiration_date = 7.days.from_now
      # creating the payload
      # { email, password? }
      payload = { email: recived_data[:email], exp: expiration_date.to_i }
      # generating the token
      jwt_token = JWT.encode payload, signature

      # return the data
      render json: { message: 'OK', token: jwt_token, expire_at: expiration_date.to_i }
    else
      render json: { message: 'Could not confirm credentials' }
    end
  end

  private
  def registration_params
    params.permit(:email, :password, :password_confirmation)
  end
  
  def login_params
    params.permit(:email, :password)
  end
end
