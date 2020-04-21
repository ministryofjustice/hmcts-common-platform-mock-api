# frozen_string_literal: true

RSpec.describe CompanyRepresentative, type: :model do
  let(:company_representative) { FactoryBot.create(:company_representative) }

  let(:json_schema) { :company_representative }

  subject { company_representative }

  describe 'validations' do
    it { should validate_inclusion_of(:position).in_array(%w[DIRECTOR SECRETARY]) }
    it { should validate_presence_of(:firstName) }
    it { should validate_presence_of(:lastName) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:defendants) }
    it { should validate_presence_of(:attendance_days) }
  end

  describe 'associations' do
    it { should have_many(:defendants).class_name('Defendant') }
    it { should have_many(:attendance_days).class_name('AttendanceDay') }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'
end
