# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AllocationDecision, type: :model do
  it { should validate_presence_of(:originatingHearingId) }
  it { should validate_presence_of(:offenceId) }
  it { should validate_presence_of(:motReasonId) }
  it { should validate_presence_of(:motReasonDescription) }
  it { should validate_presence_of(:motReasonCode) }
  it { should validate_presence_of(:allocationDecisionDate) }
  it { should validate_inclusion_of(:isSection22ALowValueShoplifting).in_array([true, false]) }
  it { should validate_inclusion_of(:isDamageValueUnder5000).in_array([true, false]) }
  it { should validate_inclusion_of(:isTreatedAsIndictableOnly).in_array([true, false]) }
  it { should validate_inclusion_of(:sentencingIndicationRequested).in_array([true, false]) }

  let(:allocation_decision) { FactoryBot.create(:allocation_decision) }

  let(:json_schema) { :allocation_decision }

  subject { allocation_decision }

  it_has_behaviour 'conforming to valid schema'

end
