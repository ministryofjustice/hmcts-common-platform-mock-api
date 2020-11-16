require 'rails_helper'

RSpec.describe "Admin::Defendants", type: :request do

  let(:defendant) { FactoryBot.create(:defendant) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV['ADMIN_USERNAME'], ENV['ADMIN_PASSWORD']) }
  
  describe "GET /show" do
    it "returns http success" do
      get "/admin/defendants/#{defendant.id}", headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end
