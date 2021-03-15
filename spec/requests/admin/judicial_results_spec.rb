# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/admin/hearings/:hearing_id/offences/:offence_id/judicial_results", type: :request do
  let(:hearing) { FactoryBot.create(:hearing, :with_prosecution_case) }
  let(:prosecution_case) { hearing.prosecution_cases.first }
  let(:offence) { prosecution_case.defendants.first.offences.first }

  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  describe "POST /judicial_results" do
    it "creates a new Hearing" do
      expect {
        post add_judicial_result_admin_hearing_url(hearing, offence), headers: headers
      }.to change(offence.judicial_results, :count).by(1)
    end

    it "creates a new judicial result with a next hearing" do
      expect {
        post add_judicial_result_admin_hearing_url(hearing, offence), headers: headers
      }.to change(NextHearing, :count).by(1)
    end

    it "redirects to the prosecution case" do
      post add_judicial_result_admin_hearing_url(hearing, offence), headers: headers
      expect(response).to redirect_to(edit_admin_hearing_url(hearing))
    end
  end

  describe "GET /judicial_result" do
    it "shows a judicial result page" do
      judicial_result = FactoryBot.create(:judicial_result_with_relationships, offence: offence)
      get judicial_result_admin_hearing_path(hearing, offence, judicial_result), headers: headers
      expect(response).to be_ok
    end
  end

  describe "GET /judicial_result/id/edit" do
    it "shows the judicial result edit page" do
      judicial_result = FactoryBot.create(:judicial_result_with_relationships, offence: offence)
      get edit_judicial_result_admin_hearing_path(hearing, offence, judicial_result), headers: headers
      expect(response).to be_ok
    end
  end

  describe "PATCH /judicial_result/id" do
    it "updates a judicial result" do
      judicial_result = FactoryBot.create(:judicial_result_with_relationships, offence: offence)
      patch update_judicial_result_admin_hearing_path(hearing, offence, judicial_result), params: { judicial_result: { label: "foo" } }, headers: headers
      expect(judicial_result.reload.label).to eql("foo")
    end

    it "renders edit page when update fails" do
      judicial_result = FactoryBot.create(:judicial_result_with_relationships, offence: offence)
      patch update_judicial_result_admin_hearing_path(hearing, offence, judicial_result), params: { judicial_result: { label: nil } }, headers: headers
      expect(response).to be_ok
    end
  end

  describe "DELETE /judicial_result/id" do
    it "deletes a judicial result" do
      judicial_result = FactoryBot.create(:judicial_result_with_relationships, offence: offence)
      expect(offence.judicial_results.count).to be(1)

      delete delete_judicial_result_admin_hearing_path(hearing, offence, judicial_result), headers: headers
      expect(offence.judicial_results.count).to be(0)
    end
  end
end
