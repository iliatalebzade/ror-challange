Rails.application.routes.draw do
  scope '/api/v1' do
    # user registration
    post 'users', to: 'users#register'

    # user sign in
    # post 'login', to: 'users#login'
  end
end
