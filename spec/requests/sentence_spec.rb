require 'rails_helper'

RSpec.describe "Sentences", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/sentence/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/sentence/show"
      expect(response).to have_http_status(:success)
    end
  end

end
