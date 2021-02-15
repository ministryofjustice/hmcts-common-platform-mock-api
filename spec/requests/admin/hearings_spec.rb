# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/admin/hearings", type: :request do
  let(:hearing) { FactoryBot.create(:hearing, :with_prosecution_case) }
  let(:prosecution_case) { hearing.prosecution_cases.first }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  let(:valid_attributes) do
    FactoryBot.attributes_for(:hearing,
                              hearing_days_attributes: [FactoryBot.attributes_for(:hearing_day)],
                              hearing_type_attributes: FactoryBot.attributes_for(:hearing_type))
  end

  let(:invalid_attributes) { FactoryBot.attributes_for(:hearing, jurisdictionType: nil) }

  describe "GET /show" do
    it "renders a successful response" do
      get admin_hearing_url(hearing), headers: headers
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_prosecution_case_hearing_url(prosecution_case), headers: headers
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_admin_hearing_url(hearing), headers: headers
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    let!(:prosecution_case) { FactoryBot.create(:prosecution_case) }

    context "with valid parameters" do
      it "creates a new Hearing" do
        expect {
          post admin_prosecution_case_hearings_url(prosecution_case), params: { hearing: valid_attributes }, headers: headers
        }.to change(prosecution_case.hearings, :count).by(1)
      end

      it "redirects to the prosecution case" do
        post admin_prosecution_case_hearings_url(prosecution_case), params: { hearing: valid_attributes }, headers: headers
        expect(response).to redirect_to(admin_prosecution_case_url(prosecution_case))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Hearing" do
        expect {
          post admin_prosecution_case_hearings_url(prosecution_case), params: { hearing: invalid_attributes }, headers: headers
        }.to change(Hearing, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_prosecution_case_hearings_url(prosecution_case), params: { hearing: invalid_attributes }, headers: headers
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { FactoryBot.attributes_for(:realistic_hearing) }

      it "updates the requested hearing" do
        patch admin_hearing_url(hearing), params: { hearing: new_attributes }, headers: headers
        hearing.reload
        expect(hearing).to have_attributes(new_attributes)
      end

      it "redirects to the prosecution case" do
        patch admin_hearing_url(hearing), params: { hearing: new_attributes }, headers: headers
        hearing.reload
        expect(response).to redirect_to(admin_prosecution_case_url(prosecution_case))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch admin_hearing_url(hearing), params: { hearing: invalid_attributes }, headers: headers
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    before { hearing.save! }

    it "destroys the requested hearing" do
      expect {
        delete admin_hearing_url(hearing), headers: headers
      }.to change(Hearing, :count).by(-1)
    end

    it "redirects to the hearings list" do
      delete admin_hearing_url(hearing), headers: headers
      expect(response).to redirect_to(admin_prosecution_case_url(prosecution_case))
    end
  end

  describe "GET /add_plea" do
    let(:offence) { prosecution_case.defendants.first.offences.first }

    it "creates a new plea" do
      expect {
        post add_plea_admin_hearing_url(hearing, offence), headers: headers
      }.to change(offence.pleas, :count).by(1)
    end

    it "redirects to the edit hearings page" do
      post add_plea_admin_hearing_url(hearing, offence), headers: headers
      expect(response).to redirect_to(edit_admin_hearing_url(hearing))
    end
  end

  describe "GET /add_allocation_decision" do
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
