# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Hearings', type: :request do
  describe 'GET /hearing/results/:id' do
    let(:hearing) { FactoryBot.create(:hearing) }

    it 'matches the response schema' do
      get "/hearing/results/#{hearing.id}"
      expect(response).to have_http_status(200)
      expect(response.body).to match_json_schema(:results_hearing_resulted_response)
    end
  end
end
