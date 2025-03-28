RSpec.describe ApplicationConclusionPublisher do
  subject(:publisher) { described_class.call(court_application:) }

  let(:court_application) { FactoryBot.create(:court_application, defendant: create(:defendant)) }

  context "with valid params" do
    it "sends a payload to LAA prosecution conclusions endpoint" do
      VCR.use_cassette("court_applications/concluded/success") do
        expect(publisher.status).to eq(202)
      end
    end
  end

  context "with connection" do
    subject(:call_publisher) { described_class.call(court_application:) }

    let(:connection) { class_double(Faraday) }

    before do
      allow(LaaConnector).to receive(:call).and_return(connection)
    end

    it "makes a POST request" do
      expect(connection).to receive(:post)
      call_publisher
    end
  end
end
