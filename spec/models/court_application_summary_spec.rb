RSpec.describe CourtApplicationSummary, type: :model do
  subject(:summary) { described_class.new(court_application_id: court_application.id) }

  let(:court_application) { FactoryBot.create(:court_application) }

  describe "to_builder" do
    it "outputs a valid payload" do
      expect(summary.to_builder.attributes!).to include(
        "applicationShortId" => court_application.short_code,
        "applicationId" => court_application.id,
        "applicationReference" => court_application.applicationReference,
        "applicationStatus" => court_application.applicationStatus,
        "applicationTitle" => court_application.court_application_type.type,
        "applicationType" => court_application.court_application_type.code,
        "receivedDate" => court_application.applicationReceivedDate.to_date,
        "applicationResult" => court_application.result_code,
      )
    end
  end
end
