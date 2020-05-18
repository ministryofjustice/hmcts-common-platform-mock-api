# frozen_string_literal: true

RSpec.describe 'Hearings', type: :request do
  let(:hearing) { FactoryBot.create(:hearing) }
  let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch('SHARED_SECRET_KEY') } }

  describe 'GET /LAAGetHearingHttpTrigger' do
    it 'matches the response schema' do
      get "/LAAGetHearingHttpTrigger?hearingId=#{hearing.id}", headers: headers
      expect(response).to have_http_status(200)
      expect(response.body).to match_json_schema(:results_hearing_resulted_response)
    end
  end

  describe 'GET /LAAGetHearingEventLogHttpTriggerFast' do
    before { FactoryBot.create(:hearing_event, hearing: hearing, eventTime: '2020-12-12 03:30') }

    it 'matches the response schema' do
      get "/LAAGetHearingEventLogHttpTriggerFast?hearingId=#{hearing.id}&date=2020-12-12", headers: headers
      expect(response).to have_http_status(200)
      expect(response.body).to match_json_schema(:results_hearing_event_log_response)
    end
  end
end
