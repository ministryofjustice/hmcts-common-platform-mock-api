require "rails_helper"

RSpec.describe "pleas", type: :request do
  describe "POST /pleas" do
    let(:headers) { { 'Authorization': authorisation } }
    let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

    let(:prosecution_case) { hearing.prosecution_cases.first }
    let(:hearing) { FactoryBot.create(:hearing, :with_prosecution_case) }
    let(:offence) { prosecution_case.defendants.first.offences.first }

    it "creates a new plea" do
      expect {
        post "/admin/hearings/#{hearing.id}/offences/#{offence.id}/pleas", headers:
      }.to change(offence.pleas, :count).by(1)
    end

    it "redirects to the edit hearings page" do
      post("/admin/hearings/#{hearing.id}/offences/#{offence.id}/pleas", headers:)
      expect(response).to redirect_to(edit_admin_hearing_url(hearing))
    end
  end
end
