# frozen_string_literal: true

RSpec.describe "ProsecutionCases", type: :request do
  describe "GET /prosecutionCases" do
    let!(:prosecution_case) do
      FactoryBot.create(:prosecution_case,
                        prosecution_case_identifier: FactoryBot.create(:prosecution_case_identifier,
                                                                       caseURN: "some-reference"))
    end

    context "when the auth header is incorrect" do
      it "returns a response with an unauthorised status" do
        get "/prosecutionCases?prosecutionCaseReference=some-reference"
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when the auth header is correct" do
      let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch("SHARED_SECRET_KEY") } }

      it "matches the response schema" do
        get("/prosecutionCases?prosecutionCaseReference=some-reference", headers:)
        expect(response).to have_http_status(:ok)
        expect(response.headers["content-type"]).to eq("application/vnd.unifiedsearch.query.laa.cases+json")
        expect(response.body).to match_json_schema(:search_prosecution_case_response)
      end

      context "when the search returns no results" do
        it "returns a response with an ok status" do
          get("/prosecutionCases?prosecutionCaseReference=incorrect-reference", headers:)
          expect(response).to have_http_status(:ok)
          expect(response.headers["content-type"]).to eq("application/vnd.unifiedsearch.query.laa.cases+json")
        end
      end
    end
  end
end
