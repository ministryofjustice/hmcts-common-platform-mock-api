# frozen_string_literal: true

RSpec.describe Jurors, type: :model do
  let(:jurors) { FactoryBot.create(:jurors) }

  let(:json_schema) { :jurors }

  subject { jurors }

  describe 'validations' do
    it { should validate_presence_of(:numberOfJurors) }
    it { should validate_presence_of(:numberOfSplitJurors) }
  end

  it_has_behaviour 'conforming to valid schema'
end
