RSpec.describe ProsecutionCaseCourtApplicationSummary, type: :model do
  subject(:summary) { described_class.new(court_application_id: court_application.id) }

  let(:court_application) { FactoryBot.create(:court_application) }

  describe "to_builder" do
    it "outputs a valid payload" do
      expect(summary.to_builder.attributes!).to include(
        "applicationShortId" => court_application.short_code,
        "applicationId" => court_application.id,
        "applicationReference" => court_application.applicationReference,
        "applicationTitle" => court_application.court_application_type.type,
        "receivedDate" => court_application.applicationReceivedDate.to_date,
      )
    end
  end
end
