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
    
  end

  private
  def registration_params
    params.permit(:email, :password, :password_confirmation)
  end
end
