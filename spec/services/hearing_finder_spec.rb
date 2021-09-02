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
    context "with one hearing" do
      let(:hearing) { FactoryBot.create(:hearing) }

      let(:params_hash) do
        { hearingId: hearing.hearing_id }
      end

      context "when hearing not resulted" do
        it "returns an empty value" do
          expect(call).to be_nil
        end
      end

      context "with an incorrect id" do
        before { hearing.update!(resulted: true) }

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

    context "with a multiday hearing" do
      let(:hearing_day_one) { FactoryBot.create(:hearing) }
      let(:hearing_day_two) { FactoryBot.create(:hearing) }
      let(:params_hash) do
        { hearingId: hearing_day_two.hearing_id }
      end

      before { hearing_day_one.update!(hearing_id: hearing_day_two.hearing_id, sitting_day: "2021-08-01", resulted: true) }

      context "when hearing two is not resulted" do
        it "returns hearing one, as the most recent resulted hearing" do
          expect(call).to eq(hearing_day_one)
        end
      end

      context "when both hearing days are resulted" do
        before { hearing_day_two.update!(sitting_day: "2021-08-08", resulted: true) }

        it "returns the hearing with the most recent sitting day" do
          expect(call).to eq(hearing_day_two)
        end
      end
    end
  end

  context "when finding by hearingId and sittingDay" do
    context "with one hearing" do
      let(:hearing) { FactoryBot.create(:hearing) }

      let(:params_hash) do
        { hearingId: hearing.hearing_id, sittingDay: hearing.sitting_day }
      end

      context "when hearing not resulted" do
        it "returns an empty value" do
          expect(call).to be_nil
        end
      end

      context "with an incorrect id" do
        before { hearing.update!(resulted: true) }

        let(:params_hash) do
          { hearingId: "6c0b7068-d4a7-4adc-a7a0-7bd5715b501d", sittingDay: hearing.sitting_day }
        end

        it "returns an empty value" do
          expect(call).to be_nil
        end
      end

      context "with an incorrect date" do
        before { hearing.update!(resulted: true) }

        let(:params_hash) do
          { hearingId: hearing.hearing_id, sittingDay: "2021-08-08" }
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

    context "with multiday hearing" do
      let(:hearing_day_one) { FactoryBot.create(:hearing) }
      let(:hearing_day_two) { FactoryBot.create(:hearing) }

      before do
        hearing_day_two.update!(hearing_id: hearing_day_one.hearing_id, sitting_day: "2021-08-01", resulted: true)
        hearing_day_one.update!(resulted: true)
      end

      context "when searching for hearing one" do
        let(:params_hash) do
          { hearingId: hearing_day_one.hearing_id, sittingDay: hearing_day_one.sitting_day }
        end

        it { is_expected.to eq(hearing_day_one) }
      end

      context "when searching for hearing two" do
        let(:params_hash) do
          { hearingId: hearing_day_two.hearing_id, sittingDay: hearing_day_two.sitting_day }
        end

        it { is_expected.to eq(hearing_day_two) }
      end
    end
  end
end
