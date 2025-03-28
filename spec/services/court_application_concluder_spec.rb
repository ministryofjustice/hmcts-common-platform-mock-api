# frozen_string_literal: true

RSpec.describe CourtApplicationConcluder do
  subject(:publish) { described_class.call(court_application_id: court_application.id, publish_to:) }

  let(:court_application) { FactoryBot.create(:court_application, defendant: create(:defendant)) }
  let(:publish_to) { "dev" }

  before { allow(ApplicationConclusionPublisher).to receive(:call) }

  it "triggers the publisher" do
    expect(ApplicationConclusionPublisher).to receive(:call).with(court_application: court_application, type: "dev")
    publish
  end

  it "concludes the prosecution case" do
    publish
    expect(court_application.defendant.prosecution_case.reload.concluded).to be(true)
  end
end
