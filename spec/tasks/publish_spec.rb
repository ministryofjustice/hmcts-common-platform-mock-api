# frozen_string_literal: true

require 'rake'

RSpec.describe 'Publish Task', type: :rake do
  subject(:publish) { Rake::Task['publish:hearing'].invoke(hearing.id) }

  before(:all) { Rails.application.load_tasks if Rake::Task.tasks.empty? }

  let(:hearing) { FactoryBot.create(:hearing) }

  it 'calls HearingResultedPublisher' do
    expect(HearingResultedPublisher).to receive(:call).with(hearing_id: hearing.id)
    publish
  end
end
