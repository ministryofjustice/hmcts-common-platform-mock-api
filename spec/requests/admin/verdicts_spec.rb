require "rails_helper"

RSpec.describe "verdicts", type: :request do
  describe "POST /verdict" do
    let(:headers) { { 'Authorization': authorisation } }
    let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

    let(:prosecution_case) { hearing.prosecution_cases.first }
    let(:hearing) { FactoryBot.create(:hearing, :with_prosecution_case) }
    let(:offence) { prosecution_case.defendants.first.offences.first }
    let(:hearing_two) { FactoryBot.create(:hearing, id: "fb5eca66-4bf2-4630-b312-74d83b01c0ae") }

    it "creates a new verdict" do
      expect {
        post "/admin/hearings/#{hearing.id}/offences/#{offence.id}/verdicts", headers:
      }.to change(offence.verdicts, :count).by(1)
    end

    it "redirects to the edit hearings page" do
      post("/admin/hearings/#{hearing.id}/offences/#{offence.id}/verdicts", headers:)

      expect(response).to redirect_to(edit_admin_hearing_url(hearing))
    end

    context "when a verdict has been created" do
      it "does not allow the creation of another verdict" do
        post("/admin/hearings/#{hearing.id}/offences/#{offence.id}/verdicts", headers:)

        expect {
          post "/admin/hearings/#{hearing.id}/offences/#{offence.id}/verdicts", headers:
        }.not_to change(offence.verdicts, :count)
      end

      it "does not allow the creation of another verdict on another hearing for the same offence" do
        prosecution_case.hearings << hearing_two
        post("/admin/hearings/#{hearing.id}/offences/#{offence.id}/verdicts", headers:)

        expect {
          post "/admin/hearings/#{hearing.id}/offences/#{offence.id}/verdicts", headers:
        }.not_to change(offence.verdicts, :count)
      end
    end
  end
end
