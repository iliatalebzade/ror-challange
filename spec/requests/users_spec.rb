require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /register" do
    it "returns http success" do
      get "/users/register"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /login" do
    it "returns http success" do
      get "/users/login"
      expect(response).to have_http_status(:success)
    end
  end

end
