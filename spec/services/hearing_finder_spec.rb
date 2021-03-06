# frozen_string_literal: true

RSpec.describe HearingFinder do
  subject(:call) { described_class.call(params) }

  let(:params) { ActionController::Parameters.new(params_hash) }

  context "with invalid params" do
    let(:params_hash) do
      { random: "value" }
    end

    it "raises an invalid params error" do
      expect {
        call
      }.to raise_error(Errors::InvalidParams)
    end
  end

  context "when finding by hearingId" do
    let(:hearing) { FactoryBot.create(:hearing) }

    let(:params_hash) do
      { hearingId: hearing.id }
    end

    it "returns an empty value" do
      expect(call).to be_nil
    end

    context "with an incorrect id" do
      let(:params_hash) do
        { hearingId: "6c0b7068-d4a7-4adc-a7a0-7bd5715b501d" }
      end

      it "returns an empty value" do
        expect(call).to be_nil
      end
    end

    context "with a resulted hearing" do
      before { hearing.update!(resulted: true) }

      it { is_expected.to eq(hearing) }
    end
  end
end
