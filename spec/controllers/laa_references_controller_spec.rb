# frozen_string_literal: true

RSpec.describe LaaReferencesController, type: :controller do
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

  describe "PUT #record" do
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

    it "returns unauthorized" do
      put :record_reference, params: laa_reference_params
      expect(response).to be_unauthorized
    end

    context "when the LaaReference exists" do
      before { laa_reference.save! }

      it "returns an accepted status" do
        request.headers["Ocp-Apim-Subscription-Key"] = ENV.fetch("SHARED_SECRET_KEY")
        put :record_reference, params: laa_reference_params
        expect(response).to have_http_status(:accepted)
      end
    end

    context "when the LaaReference is new" do
      it "returns an accepted status" do
        request.headers["Ocp-Apim-Subscription-Key"] = ENV.fetch("SHARED_SECRET_KEY")
        put :record_reference, params: laa_reference_params
        expect(response).to have_http_status(:accepted)
      end
    end
  end

  describe "PUT #record_representation_order" do
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

    it "returns unauthorized" do
      put :record_representation_order, params: laa_reference_params
      expect(response).to be_unauthorized
    end

    context "when the LaaReference exists" do
      before { laa_reference.save! }

      it "returns an accepted status" do
        request.headers["Ocp-Apim-Subscription-Key"] = ENV.fetch("SHARED_SECRET_KEY")
        put :record_representation_order, params: laa_reference_params
        expect(response).to have_http_status(:accepted)
      end
    end

    context "when the LaaReference is new" do
      it "returns an accepted status" do
        request.headers["Ocp-Apim-Subscription-Key"] = ENV.fetch("SHARED_SECRET_KEY")
        put :record_representation_order, params: laa_reference_params
        expect(response).to have_http_status(:accepted)
      end
    end
  end
end
