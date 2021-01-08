# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Defendants", type: :request do
  let(:prosecution_case) { FactoryBot.create(:prosecution_case) }
  let(:defendant) { FactoryBot.create(:defendant) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }
  let(:invalid_attributes) do
    attributes_for(:defendant,
                   defendable_type: "PersonDefendant",
                   defendable_attributes: FactoryBot.attributes_for(:person_defendant,
                                                                    person_attributes: FactoryBot.attributes_for(:person, lastName: nil)))
  end

  let(:valid_attributes) do
    FactoryBot.attributes_for(:defendant,
                              defendable_type: "PersonDefendant",
                              defendable_attributes: FactoryBot.attributes_for(:person_defendant,
                                                                               person_attributes: FactoryBot.attributes_for(:person)),
                              offences_attributes: [FactoryBot.attributes_for(:offence)])
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/defendants/#{defendant.id}", headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/defendants/#{defendant.id}/edit", headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { FactoryBot.attributes_for(:realistic_defendant) }

      it "updates the requested defendant" do
        patch admin_defendant_url(defendant), params: { defendant: new_attributes }, headers: headers
        defendant.reload
        expect(defendant).to have_attributes(new_attributes)
      end

      it "redirects to the defendant" do
        patch admin_defendant_url(defendant), params: { defendant: new_attributes }, headers: headers
        defendant.reload
        expect(response).to redirect_to(admin_defendant_url(defendant))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch admin_defendant_url(defendant), params: { defendant: invalid_attributes }, headers: headers
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    before { defendant.save! }

    it "destroys the requested defendant" do
      expect {
        delete admin_defendant_url(defendant), headers: headers
      }.to change(Defendant, :count).by(-1)
    end

    it "redirects to the defendant list" do
      delete admin_defendant_url(defendant), headers: headers
      expect(response).to redirect_to(admin_prosecution_case_url(defendant.prosecution_case))
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_prosecution_case_defendant_url(prosecution_case), headers: headers
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before { prosecution_case.save! }

    context "with valid parameters" do
      it "creates a new Defendant" do
        expect {
          post admin_prosecution_case_defendants_url(prosecution_case), params: { defendant: valid_attributes }, headers: headers
        }.to change(Defendant, :count).by(1)
      end

      it "redirects to the created defendant" do
        post admin_prosecution_case_defendants_url(prosecution_case), params: { defendant: valid_attributes }, headers: headers
        expect(response).to redirect_to(admin_defendant_url(Defendant.order(created_at: :asc).last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Defendant" do
        expect {
          post admin_prosecution_case_defendants_url(prosecution_case), params: { defendant: invalid_attributes }, headers: headers
        }.to change(Defendant, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_prosecution_case_defendants_url(prosecution_case), params: { defendant: invalid_attributes }, headers: headers
        expect(response).to be_successful
      end
    end
  end
end
