# frozen_string_literal: true

RSpec.describe "ProsecutionCases", type: :request do
  let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch("SHARED_SECRET_KEY") } }

  describe "GET /prosecutionCases" do
    let!(:prosecution_case) do
      FactoryBot.create(:prosecution_case,
                        prosecution_case_identifier: FactoryBot.create(:prosecution_case_identifier,
                                                                       caseURN: "some-reference"))
    end

    it "matches the response schema" do
      get "/prosecutionCases?prosecutionCaseReference=some-reference", headers: headers
      expect(response).to have_http_status(:ok)
      expect(response.headers["content-type"]).to eq("application/vnd.unifiedsearch.query.laa.cases+json")
      expect(response.body).to match_json_schema(:search_prosecution_case_response)
    end

    context "when the search returns no results" do
      it "returns a response with an ok status" do
        get "/prosecutionCases?prosecutionCaseReference=incorrect-reference", headers: headers
        expect(response).to have_http_status(:ok)
        expect(response.headers["content-type"]).to eq("application/vnd.unifiedsearch.query.laa.cases+json")
      end
    end
  end
end
