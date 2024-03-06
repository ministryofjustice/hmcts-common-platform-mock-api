# frozen_string_literal: true

RSpec.describe "RepresentationOrders", type: :request do
  let(:defendant) { FactoryBot.create(:defendant) }
  let(:offence) { defendant.offences.first }
  let(:status_code) { "STATUS CODE 999" }
  let(:application_reference) { "APPLICATION REFERENCE 998" }
  let(:status_date) { "2019-12-12" }
  let(:laa_reference) do
    FactoryBot.create(:laa_reference,
                      offence:,
                      statusId: SecureRandom.uuid,
                      statusDescription: "status description",
                      statusCode: status_code,
                      applicationReference: application_reference,
                      statusDate: status_date)
  end

  let(:effective_start_date) { "2019-12-12" }
  let(:effective_end_date) { "2019-12-20" }
  let(:defence_organisation) { FactoryBot.create(:defence_organisation) }

  let(:laa_reference_params) do
    {
      prosecutionCaseId: defendant.prosecution_case.id,
      defendantId: defendant.id,
      offenceId: offence.id,
      statusCode: status_code,
      applicationReference: application_reference,
      statusDate: status_date,
      effectiveStartDate: effective_start_date,
      effectiveEndDate: effective_end_date,
      defenceOrganisation: defence_organisation.to_builder.attributes!,
    }
  end

  context "when the auth header is incorrect" do
    it "returns a response with an unauthorised status" do
      post "/prosecutionCases/representationOrder/cases/#{defendant.prosecution_case.id}/defendants/#{defendant.id}/offences/#{offence.id}", params: laa_reference_params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when the auth header is correct" do
    let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch("SHARED_SECRET_KEY") } }

    context "when the LaaReference exists" do
      before { laa_reference.save! }

      it "returns an accepted status" do
        post("/prosecutionCases/representationOrder/cases/#{defendant.prosecution_case.id}/defendants/#{defendant.id}/offences/#{offence.id}", params: laa_reference_params, headers:)
        expect(response).to have_http_status(:accepted)
      end
    end

    context "when the LaaReference is new" do
      it "returns an accepted status" do
        post("/prosecutionCases/representationOrder/cases/#{defendant.prosecution_case.id}/defendants/#{defendant.id}/offences/#{offence.id}", params: laa_reference_params, headers:)
        expect(response).to have_http_status(:accepted)
      end
    end
  end
end
