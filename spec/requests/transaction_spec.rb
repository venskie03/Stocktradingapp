require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/transaction/index"
      expect(response).to have_http_status(:success)
    end
  end

end
