require "rails_helper"

RSpec.describe ApplicationConclusion, type: :model do
  let(:court_application) { FactoryBot.create(:court_application, defendant:) }
  let(:defendant) { FactoryBot.create(:defendant) }

  describe "as_json" do
    subject(:payload) { described_class.new(court_application:).to_builder.attributes! }

    it { is_expected.to include("offenceSummary") }

    context "when the court application has no offences" do
      before do
        court_application.court_application_type.update!(has_offences: false)
      end

      it { is_expected.not_to include("offenceSummary") }
    end
  end
end
