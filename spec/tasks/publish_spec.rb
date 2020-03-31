# frozen_string_literal: true

require 'rake'

RSpec.describe 'Publish Task', type: :rake do
  include ActiveSupport::Testing::TimeHelpers

  subject(:publish) { Rake::Task['publish:hearing'].invoke(hearing.id) }

  before(:all) { Rails.application.load_tasks if Rake::Task.tasks.empty? }

  let(:hearing) { FactoryBot.create(:hearing) }

  it 'calls HearingResultedPublisher' do
    freeze_time do
      expect(HearingResultedPublisher).to receive(:call).with(hearing_id: hearing.id, shared_time: Time.zone.now)
      publish
    end
  end
end
