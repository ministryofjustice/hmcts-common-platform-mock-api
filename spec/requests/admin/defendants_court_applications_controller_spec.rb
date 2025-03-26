require "rails_helper"

RSpec.describe Admin::DefendantsCourtApplicationsController, type: :request do
  let(:prosecution_case) { FactoryBot.create(:realistic_prosecution_case) }
  let(:defendant) { prosecution_case.defendants.first }
  let(:hearing_without_court_application) { prosecution_case.hearings.first }
  let(:court_application) { FactoryBot.create(:court_application, defendant:) }
  let(:court_application_to_delete) { FactoryBot.create(:defendant_court_application, defendant:) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  describe "POST #create" do
    it "creates a new court application for a defendant" do
      expect {
        post admin_defendant_defendants_court_applications_url(defendant), headers:
      }.to change(defendant.court_application, :count).by(1)
    end

    it "redirects to the defendant" do
      post(admin_defendant_defendants_court_applications_url(defendant), headers:)
      expect(response).to redirect_to(admin_defendant_url(defendant))
    end
  end

  describe "DELETE #destroy" do
    it "delete  court_application" do
      expect(CourtApplication).to exist(court_application_to_delete.id)
      expect {
        delete(admin_defendants_court_application_url(court_application_to_delete), headers:)
      }.to change(CourtApplication, :count).by(-1)
      expect(response).to redirect_to(admin_defendant_url(court_application_to_delete.defendant_id))
    end
  end
end
