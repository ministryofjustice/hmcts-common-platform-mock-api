# frozen_string_literal: true

RSpec.describe "LaaReferences", type: :request do
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

  describe "cases" do
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
          post("/prosecutionCases/laaReference/cases/#{defendant.prosecution_case.id}/defendant/#{defendant.id}/offences/#{offence.id}", params: laa_reference_params, headers:)
          expect(response).to have_http_status(:accepted)
        end
      end

      context "when the LaaReference is new" do
        it "returns an accepted status" do
          post("/prosecutionCases/laaReference/cases/#{defendant.prosecution_case.id}/defendant/#{defendant.id}/offences/#{offence.id}", params: laa_reference_params, headers:)
          expect(response).to have_http_status(:accepted)
        end
      end
    end
  end

  describe "applications" do
    let(:court_application) { create(:court_application) }
    let(:new_code) { "123" }
    let(:new_date) { "2020-01-01" }
    let(:new_reference) { "SOME REFERENCE" }
    let(:params) do
      {
        statusCode: new_code,
        applicationReference: new_reference,
        statusDate: new_date,
      }
    end

    context "when the auth header is incorrect" do
      it "returns a response with an unauthorised status" do
        post("/prosecutionCases/laaReference/applications/#{court_application.id}/subject/#{defendant.id}/offences/#{offence.id}", params:)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when the auth header is correct" do
      let(:headers) { { 'Ocp-Apim-Subscription-Key': ENV.fetch("SHARED_SECRET_KEY") } }

      context "when the LaaReference exists" do
        before do
          laa_reference.save!
          post "/prosecutionCases/laaReference/applications/#{court_application.id}/subject/#{defendant.id}/offences/#{offence.id}", params:, headers:
        end

        it "returns an accepted status" do
          expect(response).to have_http_status(:accepted)
        end

        it "updates the reference" do
          expect(laa_reference.reload).to have_attributes(
            statusCode: new_code,
            applicationReference: new_reference,
            statusDate: new_date.to_date,
          )
        end
      end

      context "when the LaaReference is new" do
        before do
          post "/prosecutionCases/laaReference/applications/#{court_application.id}/subject/#{defendant.id}/offences/#{offence.id}", params:, headers:
        end

        it "returns an accepted status" do
          expect(response).to have_http_status(:accepted)
        end

        it "creates a new reference" do
          saved_reference = LaaReference.find_by(offence_id: offence.id)

          expect(saved_reference).to have_attributes(
            statusCode: new_code,
            applicationReference: new_reference,
            statusDate: new_date.to_date,
          )
        end
      end
    end
  end
end
