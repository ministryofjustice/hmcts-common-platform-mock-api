# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Test::ProsecutionCasesController", type: :request do
  let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch("SHARED_SECRET_KEY"), "Content-Type": "application/json" } }
  let(:valid_parameters) { { "is_guilty": true, "result_code": 4057 } }
  let(:invalid_parameters) { { "is_guilty": "yes" } }
  let(:type) { "dev" }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ProsecutionCase" do
        expect {
          post(test_prosecution_cases_url, params: { prosecution_case: valid_parameters }.to_json, headers:)
          expect(response).to have_http_status(:ok)
        }.to change(ProsecutionCase, :count).by(1)
      end
    end

    context "with missing parameters" do
      it "returns a 400 error and does not create a prosecution case" do
        expect {
          post(test_prosecution_cases_url, params: { missing: invalid_parameters }.to_json, headers:)
          expect(response).to have_http_status(:bad_request)
        }.to change(ProsecutionCase, :count).by(0)
      end
    end

    context "with invalid parameters" do
      it "returns a 422 error and does not create a prosecution case" do
        expect {
          post(test_prosecution_cases_url, params: { prosecution_case: invalid_parameters }.to_json, headers:)
          expect(response).to have_http_status(:unprocessable_entity)
        }.to change(ProsecutionCase, :count).by(0)
      end
    end
  end

  describe "POST /result" do
    let(:prosecution_case) { FactoryBot.create(:generic_prosecution_case) }
    let(:hearing) { prosecution_case.hearings.first }

    it "calls the hearing resulter service" do
      expect(HearingResulter).to receive(:call).with(hearing_id: hearing.id, publish_to: type)
      post(result_test_prosecution_case_hearings_url(prosecution_case.id, hearing.hearing_id, type), headers:)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /publish" do
    let(:prosecution_case) { FactoryBot.create(:generic_prosecution_case) }

    it "calls the ProsecutionCaseConcluder" do
      expect(ProsecutionCaseConcluder).to receive(:call).with(prosecution_case_id: prosecution_case.id, publish_to: type)
      post(publish_test_prosecution_cases_url(prosecution_case.id, type), headers:)
      expect(response).to have_http_status(:ok)
    end
  end
end
