require 'rails_helper'

RSpec.describe "Entities", type: :request do
  describe "GET /create" do
    it "returns http success" do
      post "/entity/create"
      expect(response).to have_http_status(:success)
    end
  end

end
