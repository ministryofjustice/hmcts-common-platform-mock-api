# frozen_string_literal: true

namespace :publish do
  desc "Publish Hearing Resulted to LAA (Usage `rails 'publish:hearing[HEARING_ID]'`)"
  task :hearing, [:hearing_id] => :environment do |_task, args|
    hearing_id = args.hearing_id
    HearingResultedPublisher.call(hearing_id:)
  end
end
