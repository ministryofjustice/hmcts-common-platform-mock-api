# frozen_string_literal: true

RSpec.describe ProsecutionCaseConcluder do
  subject(:publish) { described_class.call(prosecution_case_id: prosecution_case.id, publish_to: publish_to) }

  let(:prosecution_case) { FactoryBot.create(:prosecution_case) }
  let(:publish_to) { "dev" }

  before { allow(ProsecutionConclusionPublisher).to receive(:call) }

  it "triggers the publisher" do
    expect(ProsecutionConclusionPublisher).to receive(:call).with(prosecution_case_id: prosecution_case.id, type: "dev")
    publish
  end

  it "concludes the prosecution case" do
    publish
    expect(prosecution_case.reload.concluded).to eq(true)
  end
end
