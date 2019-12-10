# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Publish Task', type: :rake do
  include ActiveSupport::Testing::TimeHelpers

  let(:hearing) { FactoryBot.create(:hearing) }

  before { Rails.application.class.load_tasks }

  subject { Rake::Task['publish:hearing'].invoke(hearing.id) }

  it 'calls HearingResultedPublisher' do
    freeze_time do
      expect(HearingResultedPublisher).to receive(:call).with(hearing_id: hearing.id, shared_time: Time.zone.now)
      subject
    end
  end
end
