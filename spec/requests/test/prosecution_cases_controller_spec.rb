# frozen_string_literal: true

require "rspec"

RSpec.describe "Test::ProsecutionCasesController", type: :request do
  let(:prosecution_case) { FactoryBot.create(:generic_prosecution_case) }
  let(:hearing) { prosecution_case.hearings.first }
  let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch("SHARED_SECRET_KEY") } }
  let(:valid_parameters) { { "is_guilty": "true", "result_code": "4057" } }
  let(:invalid_parameters) { { "fake_param": "fake" } }
  let(:type) { "dev" }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ProsecutionCase" do
        expect {
          post test_prosecution_cases_url, params: { prosecution_case: valid_parameters }, headers: headers
        }.to change(ProsecutionCase, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new ProsecutionCase" do
        expect {
          post test_prosecution_cases_url, params: { prosecution_case: invalid_parameters }, headers: headers
        }.to change(ProsecutionCase, :count).by(0)
      end
    end
  end

  describe "POST /result" do

    before { allow(Hearing).to receive(:find_by).and_return({ id: hearing.id }) }

    context "with valid parameters" do
      it "calls the hearing resulter service" do
        post result_test_prosecution_case_hearings_url(prosecution_case.id, hearing.id, type), headers: headers
        expect(HearingResulter).to receive(:call).with(hearing: hearing.id, publish_to: type)
      end
    end
  end

  describe "POST /publish" do
    it "calls the ProsecutionCaseConcluder" do
      expect(ProsecutionCaseConcluder).to receive(:call).with(prosecution_case_id: prosecution_case.id, publish_to: type)
      post "/admin/prosecution_conclusions/#{prosecution_case.id}/#{type}", headers: headers
    end
  end
end
