# frozen_string_literal: true

RSpec.describe LaaReferenceRecorder do
  subject(:record_reference) { described_class.call(params) }

  let(:params) { ActionController::Parameters.new(params_hash) }
  let(:defendant) { FactoryBot.create(:defendant) }
  let(:offence) { defendant.offences.first }
  let(:court_application) { FactoryBot.create(:court_application) }
  let(:status_code) { "STATUS CODE 999" }
  let(:application_reference) { "APPLICATION REFERENCE 998" }
  let(:status_date) { "2019-12-12" }
  let(:laa_reference) do
    FactoryBot.create(:laa_reference,
                      statusCode: status_code,
                      applicationReference: application_reference,
                      statusDate: status_date,
                      offence:)
  end

  context "with invalid params" do
    let(:params_hash) do
      { random: "value" }
    end

    it "raises an invalid params error" do
      expect {
        record_reference
      }.to raise_error(Errors::InvalidParams)
    end
  end

  context "with valid params linking to an offence" do
    let(:params_hash) do
      {
        prosecutionCaseId: defendant.prosecution_case.id,
        defendantId: defendant.id,
        offenceId: offence.id,
        statusCode: status_code,
        applicationReference: application_reference,
        statusDate: status_date,
      }
    end

    context "when an LaaReference does not exist" do
      it "creates the LaaReference" do
        expect { record_reference }.to change(LaaReference, :count).by(1)
      end
    end

    context "when the LaaReference exists" do
      before { laa_reference.save! }

      it "does not create a new LaaReference" do
        expect { record_reference }.not_to change(LaaReference, :count)
      end

      it "updates the LaaReference" do
        record_reference
        laa_reference.reload
        expect(laa_reference.applicationReference).to eq(application_reference)
        expect(laa_reference.statusCode).to eq(status_code)
        expect(laa_reference.statusDate).to eq(status_date)
        expect(laa_reference.statusDescription).to eq("FAKE NEWS")
      end

      it { is_expected.to eq laa_reference }
    end
  end

  context "with valid params linking to a court application" do
    let(:params_hash) do
      {
        prosecutionCaseId: defendant.prosecution_case.id,
        defendantId: defendant.id,
        offenceId: court_application.id,
        statusCode: status_code,
        applicationReference: application_reference,
        statusDate: status_date,
      }
    end

    let(:laa_reference) do
      FactoryBot.create(:laa_reference,
                        statusCode: status_code,
                        applicationReference: application_reference,
                        statusDate: status_date,
                        court_application:)
    end

    context "when an LaaReference does not exist" do
      it "creates the LaaReference" do
        expect { record_reference }.to change(LaaReference, :count).by(1)
      end
    end

    context "when the LaaReference exists" do
      before { laa_reference.save! }

      it "does not create a new LaaReference" do
        expect { record_reference }.not_to change(LaaReference, :count)
      end

      it "updates the LaaReference" do
        record_reference
        laa_reference.reload
        expect(laa_reference.applicationReference).to eq(application_reference)
        expect(laa_reference.statusCode).to eq(status_code)
        expect(laa_reference.statusDate).to eq(status_date)
        expect(laa_reference.statusDescription).to eq("FAKE NEWS")
      end

      it { is_expected.to eq laa_reference }
    end
  end
end
