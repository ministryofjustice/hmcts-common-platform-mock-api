# frozen_string_literal: true

require "rspec"

RSpec.describe ProsecutionCasesDataService do
  subject(:call) { described_class.call(params) }

  let(:params) { ActionController::Parameters.new(params_hash) }

  context "when given valid input" do
    let(:params_hash) do
      { is_guilty: true, result_code: 1234 }
    end

    it "creates the correct prosecution case test data" do
      expect {
        created_data = call
        expect(created_data.hearings.count).to eq(1)
        expect(created_data.hearings[0].jurisdictionType).to eq("CROWN")
        expect(created_data.hearings[0].court_centre_id).to eq("e2b8580f-5247-30f9-905f-4b8136b23318")
        expect(created_data.defendants.count).to eq(1)
        expect(created_data.defendants[0].offences.count).to eq(1)
        expect(created_data.defendants[0].offences[0].verdicts.count).to eq(1)
        expect(created_data.defendants[0].offences[0].verdicts[0].verdict_type.description).to eq("Guilty")
        expect(created_data.defendants[0].offences[0].judicial_results[0].cjsCode).to eq(params_hash[:result_code].to_s)
      }.to change(ProsecutionCase, :count).by(1)
    end
  end

  context "when is_guilty parameter is not true" do
    let(:params_hash) do
      { is_guilty: false, result_code: 1234 }
    end

    it "creates a prosecution case with a not guilty verdict" do
      created_data = call
      expect(created_data.defendants[0].offences[0].verdicts[0].verdict_type.description).to eq("Not Guilty")
    end
  end
end
