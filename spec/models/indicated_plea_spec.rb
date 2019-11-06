# frozen_string_literal: true

RSpec.describe IndicatedPlea, type: :model do
  let(:indicated_plea) { FactoryBot.create(:indicated_plea) }

  let(:json_schema) { :indicated_plea }

  subject { indicated_plea }

  describe 'validations' do
    it { should validate_presence_of(:offenceId) }
    it { should validate_presence_of(:indicatedPleaDate) }
    it { should validate_presence_of(:indicatedPleaValue) }
    it { should validate_presence_of(:source) }
    it do
      should validate_inclusion_of(:indicatedPleaValue)
        .in_array(%w[INDICATED_GUILTY INDICATED_NOT_GUILTY NO_INDICATION])
    end
    it do
      should validate_inclusion_of(:source)
        .in_array(%w[ONLINE IN_COURT])
    end
  end

  it_has_behaviour 'conforming to valid schema'

  it_has_a 'realistic factory'
end
