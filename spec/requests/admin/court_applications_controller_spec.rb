require "rails_helper"

RSpec.describe "/admin/court_application", type: :request do
  let(:hearing_without_court_application) { FactoryBot.create(:hearing) }
  let(:hearing) { FactoryBot.create(:hearing, :with_court_application) }
  let(:court_application) { hearing.court_applications.first }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  describe "GET /create" do
    it "creates a new court application" do
      expect {
        post admin_hearing_court_applications_url(hearing_without_court_application), headers: headers
      }.to change(hearing_without_court_application.court_applications, :count).by(1)
    end

    it "redirects to the hearing" do
      post admin_hearing_court_applications_url(hearing_without_court_application), headers: headers
      expect(response).to redirect_to(admin_hearing_url(hearing_without_court_application))
    end
  end

  describe "GET /show" do
    it "render a successful response" do
      get admin_court_application_url(court_application), headers: headers
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_admin_court_application_url(court_application), headers: headers
      expect(response).to be_successful
    end
  end

  describe "DELETE /destroy" do
    before { hearing.save! }

    it "destroys the requested court_application" do
      expect {
        delete admin_court_application_url(court_application.id), headers: headers
      }.to change(CourtApplication, :count).by(-1)
    end

    it "redirects to the hearings list" do
      delete admin_court_application_url(court_application.id), headers: headers
      expect(response).to redirect_to(admin_hearing_url(hearing))
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { id: court_application.id, applicationReceivedDate: "2024-01-01".to_date } }

      it "updates the requested court_application_type" do
        patch admin_court_application_url(court_application), params: { court_application: new_attributes }, headers: headers
        court_application.reload
        expect(court_application).to have_attributes(new_attributes)
      end

      it "redirects to the hearing" do
        patch admin_court_application_url(court_application), params: { court_application: new_attributes }, headers: headers
        court_application.reload
        expect(response).to redirect_to(admin_court_application_url(court_application))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { id: nil, applicationReceivedDate: nil } }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch admin_court_application_url(court_application), params: { court_application: invalid_attributes }, headers: headers
        expect(response).to be_successful
      end
    end
  end
end
