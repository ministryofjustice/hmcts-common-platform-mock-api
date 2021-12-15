# frozen_string_literal: true

RSpec.describe "HearingLogs", type: :request do
  let(:hearing) { FactoryBot.create(:hearing, resulted: true) }

  describe "GET /hearing/hearingLog" do
    let(:hearing_day) { hearing.hearing_days.first }
    let(:params) { { hearingId: hearing.id, date: hearing_day.sittingDay.strftime("%Y-%m-%d") } }

    before { FactoryBot.create(:hearing_event, hearing_day: hearing_day) }

    context "when the auth header is incorrect" do
      it "returns a response with an unauthorised status" do
        get "/hearing/hearingLog", params: params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when the auth header is correct" do
      let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch("SHARED_SECRET_KEY") } }

      it "returns a response with an ok status" do
        get "/hearing/hearingLog", params: params, headers: headers
        expect(response).to have_http_status(:ok)
      end

      it "matches the response schema" do
        get "/hearing/hearingLog", params: params, headers: headers
        expect(response.body).to match_json_schema(:results_hearing_event_log_response)
      end
    end
  end
end
