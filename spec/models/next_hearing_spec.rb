# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NextHearing, type: :model do
  describe 'associations' do
    it { should have_many(:judicial_roles).class_name('JudicialRole') }
    it { should have_many(:next_hearing_prosecution_cases).class_name('NextHearingProsecutionCase') }
    it { should have_many(:next_hearing_court_applications).class_name('NextHearingCourtApplication') }
  end
  describe 'validations' do
    it { should validate_presence_of(:hearing_type) }
    it { should validate_presence_of(:court_centre) }
    it { should validate_presence_of(:estimatedMinutes) }
    it { should validate_presence_of(:listedStartDateTime) }
    it do
      should validate_inclusion_of(:jurisdictionType)
        .in_array(%w[MAGISTRATES CROWN])
    end
    it do
      should validate_inclusion_of(:hearingLanguage)
        .in_array(%w[ENGLISH WELSH])
    end
  end

  let(:next_hearing) { FactoryBot.create(:next_hearing) }

  it 'matches the given schema' do
    expect(next_hearing.to_builder.target!).to match_json_schema(:next_hearing)
  end
end
