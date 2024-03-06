# frozen_string_literal: true

RSpec.describe "Hearings", type: :request do
  let(:hearing) { FactoryBot.create(:hearing) }
  let(:params) { { hearingId: hearing.hearing_id } }

  describe "GET /hearing/results" do
    context "when the auth header is incorrect" do
      it "returns a response with an unauthorised status" do
        get("/hearing/results", params:)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when the auth header is correct" do
      let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch("SHARED_SECRET_KEY") } }

      it "returns an ok status" do
        get("/hearing/results", params:, headers:)
        expect(response).to have_http_status(:ok)
      end

      context "when the hearing is resulted" do
        before { hearing.update!(resulted: true) }

        it "returns an ok status" do
          get("/hearing/results", params:, headers:)
          expect(response).to have_http_status(:ok)
        end

        it "matches the response schema" do
          get("/hearing/results", params:, headers:)
          expect(response.body).to match_json_schema(:results_hearing_resulted_response)
        end
      end

      context "when the hearing does not exist" do
        it "returns an ok status" do
          get("/hearing/results?hearingId=55001fc2-3587-488f-823f-a056502fc512", headers:)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
