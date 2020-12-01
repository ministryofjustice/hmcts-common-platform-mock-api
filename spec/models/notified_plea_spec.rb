# frozen_string_literal: true

RSpec.describe NotifiedPlea, type: :model do
  let(:notified_plea) { FactoryBot.create(:notified_plea) }

  let(:json_schema) { :notified_plea }

  subject { notified_plea }

  describe 'validations' do
    it { should validate_presence_of(:notifiedPleaDate) }
    it { should validate_presence_of(:notifiedPleaValue) }
    it do
      should validate_inclusion_of(:notifiedPleaValue)
        .in_array(%w[NOTIFIED_GUILTY NOTIFIED_NOT_GUILTY NO_NOTIFICATION])
    end
  end

  it { is_expected.to belong_to(:offence) }

  it_has_behaviour 'conforming to valid schema'
  it_has_a 'realistic factory'
end
