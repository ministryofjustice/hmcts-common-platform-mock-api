require "rails_helper"

RSpec.describe "POST /admin/court_application/:id/result/:hearing_id/:publish_to" do
  let(:hearing) { create(:hearing) }
  let(:court_application) { create(:court_application) }
  let(:publish_to) { "dev" }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  before do
    allow(HearingResulter).to receive(:call).with(hearing_id: hearing.id, publish_to:).and_return(outcome)
    post(admin_court_application_result_hearing_path(court_application, hearing, publish_to), headers:)
  end

  context "when hearing publishing is successful" do
    let(:outcome) { true }

    it "redirects with a positive message" do
      expect(response).to redirect_to admin_court_application_path(court_application)
      expect(flash[:notice]).to eq("Hearing was successfully resulted")
    end
  end

  context "when hearing publishing fails" do
    let(:outcome) { false }

    it "redirects with a negative message" do
      expect(response).to redirect_to admin_court_application_path(court_application)
      expect(flash[:notice]).to eq("Hearing could not be resulted")
    end
  end
end
