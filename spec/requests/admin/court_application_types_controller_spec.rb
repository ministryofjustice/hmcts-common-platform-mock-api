# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/admin/court_application_type", type: :request do
  let(:hearing) { FactoryBot.create(:hearing, :with_court_application) }
  let(:court_application) { hearing.court_applications.first }
  let(:court_application_type) { court_application.court_application_type }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  describe "GET /edit" do
    it "render a successful response" do
      get(edit_admin_court_application_court_application_type_url(court_application), headers:)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { code: "code", type: "type", legislation: "legislation" } }

      it "updates the requested court_application_type" do
        patch(admin_court_application_court_application_type_url(court_application), params: { court_application_type: new_attributes }, headers:)
        court_application_type.reload
        expect(court_application_type).to have_attributes(new_attributes)
      end

      it "redirects to the hearing" do
        patch(admin_court_application_court_application_type_url(court_application), params: { court_application_type: new_attributes }, headers:)
        court_application_type.reload
        expect(response).to redirect_to(admin_court_application_url(court_application))
      end
    end
  end
end
