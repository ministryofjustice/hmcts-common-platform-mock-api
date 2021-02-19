require "rails_helper"

RSpec.describe "/admin/allocation_decisions", type: :request do
  let(:hearing) { FactoryBot.create(:hearing, :with_prosecution_case) }
  let(:prosecution_case) { hearing.prosecution_cases.first }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  describe "POST /allocation_decisions" do
    let(:offence) { prosecution_case.defendants.first.offences.first }

    it "creates a new allocation decision" do
      expect {
        post add_allocation_decision_admin_hearing_url(hearing, offence), headers: headers
      }.to change(offence.allocation_decisions, :count).by(1)
    end

    it "redirects to the edit hearings page" do
      post add_allocation_decision_admin_hearing_url(hearing, offence), headers: headers
      expect(response).to redirect_to(edit_admin_hearing_url(hearing))
    end
  end
end
