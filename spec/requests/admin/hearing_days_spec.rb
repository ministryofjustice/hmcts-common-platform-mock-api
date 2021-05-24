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
      hearing_day = hearing.hearing_days.first
      get edit_hearing_day_admin_hearing_path(hearing, hearing_day), headers: headers
      expect(response).to be_ok
    end
  end

  describe "PATCH /hearing_days/id" do
    it "updates a hearing day" do
      hearing_day = FactoryBot.create(:hearing_day, hearing: hearing)
      patch update_hearing_day_admin_hearing_path(hearing, hearing_day), params: { hearing_day: { listingSequence: 9 } }, headers: headers
      expect(hearing_day.reload.listingSequence).to be(9)
    end

    it "renders edit page when update fails" do
      hearing_day = FactoryBot.create(:hearing_day, hearing: hearing)
      patch update_hearing_day_admin_hearing_path(hearing, hearing_day), params: { hearing_day: { sittingDay: nil } }, headers: headers
      expect(response).to be_ok
    end
  end

  describe "DELETE /hearing_days/id" do
    it "deletes a hearing day" do
      hearing_days = FactoryBot.create(:hearing_day, hearing: hearing)
      expect(hearing.hearing_days.count).to be(2)

      delete delete_hearing_day_admin_hearing_path(hearing, hearing_days), headers: headers
      expect(hearing.hearing_days.count).to be(1)
    end
  end
end
