require "rails_helper"

RSpec.describe "/admin/repondent", type: :request do
  let(:hearing) { FactoryBot.create(:hearing, :with_court_application) }
  let(:respondent) { hearing.court_applications.first.respondents.first }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  describe "GET /edit" do
    it "render a successful response" do
      get edit_admin_respondent_url(respondent), headers: headers
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { synonym: "test" } }

      it "updates the requested respondent" do
        patch admin_respondent_url(respondent), params: { court_application_party: new_attributes }, headers: headers
        respondent.reload
        expect(respondent).to have_attributes(new_attributes)
      end

      it "redirects to the hearing" do
        patch admin_respondent_url(respondent), params: { court_application_party: new_attributes }, headers: headers
        respondent.reload
        expect(response).to redirect_to(admin_hearing_url(hearing))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { synonym: nil } }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch admin_respondent_url(respondent), params: { court_application_party: invalid_attributes }, headers: headers
        expect(response).to be_successful
      end
    end
  end
end
