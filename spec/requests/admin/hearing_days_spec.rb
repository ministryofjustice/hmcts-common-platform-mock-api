# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/admin/hearings/:hearing_id/hearing_days", type: :request do
  let(:hearing) { FactoryBot.create(:hearing) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  describe "POST /hearing_days" do
    it "creates a new Hearing days" do
      expect {
        post add_hearing_days_admin_hearing_url(hearing), headers: headers
      }.to change(hearing.hearing_days, :count).by(1)
    end

    it "redirects to the hearing show page" do
      post add_hearing_days_admin_hearing_url(hearing), headers: headers
      expect(response).to redirect_to(admin_hearing_url(hearing))
    end
  end

  describe "GET /hearing_days/:hearing_day_id" do
    it "shows a hearing day page" do
      hearing_day = hearing.hearing_days.first
      get hearing_day_admin_hearing_path(hearing, hearing_day), headers: headers
      expect(response).to be_ok
    end
  end

  describe "GET /hearing_days/id/edit" do
    it "shows the hearing day edit page" do
      hearing_days = FactoryBot.create(:hearing_days_with_relationships, offence: offence)
      get edit_hearing_days_admin_hearing_path(hearing, offence, hearing_days), headers: headers
      expect(response).to be_ok
    end
  end

  describe "PATCH /hearing_days/id" do
    it "updates a judicial result" do
      hearing_days = FactoryBot.create(:hearing_days_with_relationships, offence: offence)
      patch update_hearing_days_admin_hearing_path(hearing, offence, hearing_days), params: { hearing_days: { label: "foo" } }, headers: headers
      expect(hearing_days.reload.label).to eql("foo")
    end

    it "renders edit page when update fails" do
      hearing_days = FactoryBot.create(:hearing_days_with_relationships, offence: offence)
      patch update_hearing_days_admin_hearing_path(hearing, offence, hearing_days), params: { hearing_days: { label: nil } }, headers: headers
      expect(response).to be_ok
    end
  end

  describe "DELETE /hearing_days/id" do
    it "deletes a judicial result" do
      hearing_days = FactoryBot.create(:hearing_days_with_relationships, offence: offence)
      expect(offence.hearing_days.count).to be(1)

      delete delete_hearing_days_admin_hearing_path(hearing, offence, hearing_days), headers: headers
      expect(offence.hearing_days.count).to be(0)
    end
  end
end
