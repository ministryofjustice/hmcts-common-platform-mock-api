# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Hearings', type: :request do
  describe 'GET /hearing/result-sit/LAAGetHearingHttpTrigger' do
    let(:hearing) { FactoryBot.create(:hearing) }
    let(:headers) { { 'LAHearing-Subscription-Key': ENV.fetch('SHARED_SECRET_KEY_HEARING') } }

    it 'matches the response schema' do
      get "/hearing/result-sit/LAAGetHearingHttpTrigger?hearingId=#{hearing.id}", headers: headers
      expect(response).to have_http_status(200)
      expect(response.body).to match_json_schema(:results_hearing_resulted_response)
    end
  end
end
