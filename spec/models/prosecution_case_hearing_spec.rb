# frozen_string_literal: true

RSpec.describe ProsecutionCaseHearing, type: :model do
  describe 'associations' do
    it { should belong_to(:hearing).class_name('Hearing') }
    it { should belong_to(:prosecution_case).class_name('ProsecutionCase') }
  end
end
