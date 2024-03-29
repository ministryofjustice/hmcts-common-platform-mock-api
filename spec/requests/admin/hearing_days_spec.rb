# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/admin/hearings/:hearing_id/hearing_days", type: :request do
  let(:hearing) { FactoryBot.create(:hearing) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  describe "POST /hearing_days" do
    it "creates a new Hearing days" do
      expect {
        post admin_hearing_hearing_days_url(hearing), headers:
      }.to change(hearing.hearing_days, :count).by(1)
    end

    it "redirects to the hearing show page" do
      post(admin_hearing_hearing_days_url(hearing), headers:)
      expect(response).to redirect_to(admin_hearing_url(hearing))
    end
  end

  describe "GET /hearing_days/:id" do
    it "shows a hearing day page" do
      hearing_day = hearing.hearing_days.first
      get(admin_hearing_day_url(hearing_day), headers:)
      expect(response).to be_ok
    end
  end

  describe "GET /hearing_days/:id/edit" do
    it "shows the hearing day edit page" do
      hearing_day = hearing.hearing_days.first
      get(edit_admin_hearing_day_url(hearing_day), headers:)
      expect(response).to be_ok
    end
  end

  describe "PATCH /hearing_days/:id" do
    it "updates a hearing day" do
      hearing_day = FactoryBot.create(:hearing_day, hearing:)
      patch(admin_hearing_day_url(hearing_day), params: { hearing_day: { listingSequence: 9 } }, headers:)
      expect(hearing_day.reload.listingSequence).to be(9)
    end

    it "renders edit page when update fails" do
      hearing_day = FactoryBot.create(:hearing_day, hearing:)
      patch(admin_hearing_day_url(hearing_day), params: { hearing_day: { sittingDay: nil } }, headers:)
      expect(response).to be_ok
    end
  end

  describe "DELETE /hearing_days/:id" do
    it "deletes a hearing day" do
      hearing_day = FactoryBot.create(:hearing_day, hearing:)
      expect(hearing.hearing_days.count).to be(2)

      delete(admin_hearing_day_path(hearing_day), headers:)
      expect(hearing.hearing_days.count).to be(1)
    end
  end
end
