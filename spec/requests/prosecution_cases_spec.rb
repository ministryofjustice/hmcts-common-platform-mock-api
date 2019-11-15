# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ProsecutionCases', type: :request do
  describe 'GET /prosecutionCases' do
    let!(:prosecution_case) do
      FactoryBot.create(:prosecution_case,
                        prosecution_case_identifier: FactoryBot.create(:prosecution_case_identifier,
                                                                       caseURN: 'some-reference'))
    end

    it 'matches the response schema' do
      get '/prosecutionCases?prosecutionCaseReference=some-reference'
      expect(response).to have_http_status(200)
      expect(response.body).to match_json_schema(:search_prosecution_case_response)
    end
  end
end
