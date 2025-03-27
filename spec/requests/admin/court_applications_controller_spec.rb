require "rails_helper"

RSpec.describe "/admin/court_application", type: :request do
  let(:prosecution_case) { FactoryBot.create(:realistic_prosecution_case) }
  let(:hearing_without_court_application) { prosecution_case.hearings.first }
  let(:hearing) { FactoryBot.create(:hearing, :with_court_application, :with_prosecution_case) }
  let(:court_application) { FactoryBot.create(:court_application) }
  let(:valid_attributes) { { applicationReceivedDate: "2025-03-25 00:00:00", court_application_party: court_application.court_application_party, applicationStatus: "LISTED", parentApplicationId: "63de9f8e-ead3-4d29-a26a-6508e2f42c58" } }
  let(:invalid_attributes) { { applicationReceivedDate: "2025-03-25 00:00:00", court_application_party_id: "63de9f8e-ead3-4d29-a26a-6508e2f42c58", applicationStatus: "LISTED", parentApplicationId: "63de9f8e-ead3-4d29-a26a-6508e2f42c58" } }
  let(:court_application_to_delete) { FactoryBot.create(:court_application) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  before do
    court_application.hearing_id = hearing.id

    CourtApplicationProsecutionCase.find_or_create_by!(
      court_application:,
      prosecution_case:,
    )

    CourtApplicationHearing.find_or_create_by!(
      court_application:,
      hearing:,
    )
  end

  describe "GET #create" do
    it "creates a new court application" do
      expect {
        post admin_hearing_court_applications_url(hearing_without_court_application), headers:
      }.to change(hearing_without_court_application.court_applications, :count).by(1)
    end

    it "redirects to the hearing" do
      post(admin_hearing_court_applications_url(hearing_without_court_application), headers:)
      expect(response).to redirect_to(admin_hearing_url(hearing_without_court_application))
    end
  end

  describe "GET #show" do
    it "render a successful response" do
      get(admin_court_application_url(court_application), headers:)
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    before do
      get(edit_admin_court_application_url(court_application), headers:)
    end

    it "render a successful response" do
      expect(response).to be_successful
    end

    it "assigns @court_application" do
      expect(assigns(:court_application)).to eq(court_application)
    end

    it "assigns @defendants from prosecution_case" do
      prosecution_case = ProsecutionCase.find(court_application.prosecution_case)
      expect(assigns(:defendants)).to eq(prosecution_case.defendants)
    end

    it "assigns @hearings from prosecution_case" do
      prosecution_case = ProsecutionCase.find(court_application.prosecution_case)
      expect(assigns(:hearings)).to eq(prosecution_case.hearings)
    end
  end

  describe "GET #new" do
    it "Creates court_application object" do
      get(new_admin_hearing_court_application_path(hearing.id), headers:)
      expect(response).to have_http_status(:ok)
      expect(assigns(:court_application)).to respond_to(:id)
      expect(assigns(:court_application)).to respond_to(:applicationStatus)
    end
  end

  describe "GET #index" do
    it "assigns @court_applications" do
      get(admin_court_applications_path, headers:)
      expect(assigns(:court_applications)).to be_a(ActiveRecord::Relation)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT #update" do
    it "assigns @court_application" do
      get(edit_admin_court_application_path(court_application), headers:)
      expect(assigns(:court_application)).to eq(court_application)
      expect(response).to have_http_status(:ok)
    end

    context "with invalid parameters" do
      it "does not update the court application" do
        court_application_test = court_application
        put(admin_court_application_path(court_application_test), params: { id: court_application_test.id, court_application: invalid_attributes }, headers:)
        court_application_test.reload
        expect(court_application.parentApplicationId).to eq(court_application_test.parentApplicationId)
      end

      it "redirects the edit template" do
        put(admin_court_application_path(court_application), params: { id: court_application.id, court_application: invalid_attributes }, headers:)
        expect(response).to render_template(:edit)
      end
    end

    context "with valid parameters" do
      it "updates the requested court application" do
        put(admin_court_application_path(court_application), params: { id: court_application.id, court_application: valid_attributes }, headers:)
        court_application.reload
        expect(court_application.applicationStatus).to eq("LISTED")
        expect(court_application.parentApplicationId).to eq("63de9f8e-ead3-4d29-a26a-6508e2f42c58")
      end

      it "redirects to the court application" do
        put(admin_court_application_path(court_application), params: { id: court_application.id, court_application: valid_attributes }, headers:)
        expect(response).to redirect_to(admin_court_application_path(court_application))
      end

      it "sets a success notice" do
        put(admin_court_application_path(court_application), params: { id: court_application.id, court_application: valid_attributes }, headers:)
        expect(flash[:notice]).to eq("Court application was successfully updated.")
      end
    end
  end

  describe "DELETE #destroy" do
    it "delete court_application" do
      expect(CourtApplication).to exist(court_application_to_delete.id)
      expect {
        delete(admin_court_application_path(court_application_to_delete), headers:)
      }.to change(CourtApplication, :count).by(-1)
      expect(response).to redirect_to(admin_hearing_url(court_application_to_delete.hearing_id))
    end
  end
end
