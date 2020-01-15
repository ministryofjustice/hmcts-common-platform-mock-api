# frozen_string_literal: true

RSpec.describe 'ProsecutionCases', type: :request do
  let(:headers) { { 'LAASearchCase-Subscription-Key': ENV.fetch('SHARED_SECRET_KEY_SEARCH_PROSECUTION_CASE') } }

  describe 'GET /search/case-sit/prosecutionCases' do
    let!(:prosecution_case) do
      FactoryBot.create(:prosecution_case,
                        prosecution_case_identifier: FactoryBot.create(:prosecution_case_identifier,
                                                                       caseURN: 'some-reference'))
    end

    it 'matches the response schema' do
      get '/search/case-sit/prosecutionCases?prosecutionCaseReference=some-reference', headers: headers
      expect(response).to have_http_status(200)
      # For some odd reason the HMCTS results do not contain the prosecutionCases key as defined by the schema
      # but only the array items instead
      expect(response.body).to match_json_schema(:search_prosecution_case_response, fragment: '#/properties/prosecutionCases')
    end

    context 'when the search returns no results' do
      it 'matches the response schema' do
        get '/search/case-sit/prosecutionCases?prosecutionCaseReference=incorrect-reference', headers: headers
        expect(response).to have_http_status(200)
        expect(response.body).to match_json_schema(:search_prosecution_case_response)
      end
    end
  end
end
