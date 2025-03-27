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
                      statusCode: "old code",
                      applicationReference: "old reference",
                      statusDate: "2000-01-01")
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

  describe "cases" do
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

  describe "application" do
    let(:subject_id) { SecureRandom.uuid }
    let(:application_id) { SecureRandom.uuid }

    context "when the auth header is incorrect" do
      it "returns a response with an unauthorised status" do
        post "/prosecutionCases/representationOrder/applications/#{application_id}/subject/#{subject_id}/offences/#{offence.id}", params: laa_reference_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when the auth header is correct" do
      let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch("SHARED_SECRET_KEY") } }

      context "when the LaaReference exists" do
        before do
          laa_reference.save!
          post("/prosecutionCases/representationOrder/applications/#{application_id}/subject/#{subject_id}/offences/#{offence.id}", params: laa_reference_params, headers:)
        end

        it "returns an accepted status" do
          expect(response).to have_http_status(:accepted)
        end

        it "updates the reference" do
          expect(laa_reference.reload).to have_attributes(
            applicationReference: application_reference,
            statusCode: status_code,
            statusDate: Date.parse(status_date),
            effectiveStartDate: Date.parse(effective_start_date),
            effectiveEndDate: Date.parse(effective_end_date),
          )
        end
      end

      context "when the LaaReference is new" do
        before do
          post("/prosecutionCases/representationOrder/applications/#{application_id}/subject/#{subject_id}/offences/#{offence.id}", params: laa_reference_params, headers:)
        end

        it "returns an accepted status" do
          expect(response).to have_http_status(:accepted)
        end

        it "creates a new reference" do
          expect(LaaReference.find_by(offence_id: offence.id)).to have_attributes(
            applicationReference: application_reference,
            statusCode: status_code,
            statusDate: Date.parse(status_date),
            effectiveStartDate: Date.parse(effective_start_date),
            effectiveEndDate: Date.parse(effective_end_date),
          )
        end
      end
    end
  end
end
