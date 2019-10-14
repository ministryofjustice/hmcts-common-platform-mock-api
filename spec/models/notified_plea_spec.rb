require 'rails_helper'

RSpec.describe NotifiedPlea, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:offenceId) }
    it { should validate_presence_of(:notifiedPleaDate) }
    it { should validate_presence_of(:notifiedPleaValue) }
    it do
      should validate_inclusion_of(:notifiedPleaValue).
        in_array(['NOTIFIED_GUILTY', 'NOTIFIED_NOT_GUILTY', 'NO_NOTIFICATION'])
    end
  end

  let(:notified_plea) { FactoryBot.create(:notified_plea) }

  it 'matches the given schema' do
    expect(notified_plea.to_builder.target!).to match_json_schema(:notified_plea)
  end
end
