# frozen_string_literal: true

RSpec.describe "LaaReferences", type: :request do
  let(:defendant) { FactoryBot.create(:defendant) }
  let(:offence) { defendant.offences.first }
  let(:status_code) { "STATUS CODE 999" }
  let(:application_reference) { "APPLICATION REFERENCE 998" }
  let(:status_date) { "2019-12-12" }
  let(:laa_reference) do
    FactoryBot.create(:laa_reference,
                      offence: offence,
                      statusId: SecureRandom.uuid,
                      statusDescription: "status description",
                      statusCode: status_code,
                      applicationReference: application_reference,
                      statusDate: status_date)
  end

  let(:laa_reference_params) do
    {
      prosecutionCaseId: defendant.prosecution_case.id,
      defendantId: defendant.id,
      offenceId: offence.id,
      statusCode: status_code,
      applicationReference: application_reference,
      statusDate: status_date,
    }
  end

  context "when the auth header is incorrect" do
    it "returns a response with an unauthorised status" do
      post "/prosecutionCases/laaReference/cases/#{defendant.prosecution_case.id}/defendant/#{defendant.id}/offences/#{offence.id}", params: laa_reference_params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when the auth header is correct" do
    let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch("SHARED_SECRET_KEY") } }

    context "when the LaaReference exists" do
      before { laa_reference.save! }

      it "returns an accepted status" do
        post "/prosecutionCases/laaReference/cases/#{defendant.prosecution_case.id}/defendant/#{defendant.id}/offences/#{offence.id}", params: laa_reference_params, headers: headers
        expect(response).to have_http_status(:accepted)
      end
    end

    context "when the LaaReference is new" do
      it "returns an accepted status" do
        post "/prosecutionCases/laaReference/cases/#{defendant.prosecution_case.id}/defendant/#{defendant.id}/offences/#{offence.id}", params: laa_reference_params, headers: headers
        expect(response).to have_http_status(:accepted)
      end
    end
  end
end
