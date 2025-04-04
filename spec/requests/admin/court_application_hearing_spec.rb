require "rails_helper"

RSpec.describe "/admin/court_application_hearing", type: :request do
  let(:prosecution_case) { FactoryBot.create(:realistic_prosecution_case) }
  let(:hearing) { FactoryBot.create(:hearing, :with_court_application, :with_prosecution_case) }
  let(:court_application) { FactoryBot.create(:court_application) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  describe "GET #create" do
    it "creates a new court application" do
      expect {
        post admin_court_application_hearing_create_url(court_application_id: court_application.id, hearing_id: prosecution_case.hearings.first.id), headers:
      }.to change(court_application.court_hearings, :count).by(1)
    end

    it "redirects to the hearing" do
      post(admin_court_application_hearing_create_url(court_application_id: court_application.id, hearing_id: prosecution_case.hearings.first.id), headers:)
      expect(response).to redirect_to(admin_court_application_path(court_application))
    end
  end

  describe "DELETE #destroy" do
    let!(:court_application_hearing) { CourtApplicationHearing.create!(hearing: hearing, court_application: court_application) }

    it "delete court_application" do
      expect(CourtApplicationHearing).to exist(court_application_hearing.id)
      expect {
        delete(admin_court_application_hearing_destroy_url(court_application_id: court_application_hearing.court_application_id, hearing_id: court_application_hearing.hearing_id), headers:)
      }.to change(CourtApplicationHearing, :count).by(-1)
      expect(response).to redirect_to(admin_court_application_path(court_application))
    end
  end
end
