# frozen_string_literal: true

RSpec.describe "Status", type: :request do
  describe "GET /status" do
    it "returns an ok status" do
      get "/status"
      expect(response).to have_http_status(:ok)
    end
  end
end
