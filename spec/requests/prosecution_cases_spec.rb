# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ProsecutionCases', type: :request do
  describe 'GET /prosecution_cases' do
    let!(:prosecution_case) { FactoryBot.create(:prosecution_case) }

    it 'matches the response schema' do
      get '/prosecutionCases'
      expect(response).to have_http_status(200)
      expect(response.body).to match_json_schema(:search_prosecution_case_response)
    end
  end
end
