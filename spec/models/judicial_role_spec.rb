# frozen_string_literal: true

RSpec.describe JudicialRole, type: :model do
  subject { judicial_role }

  let(:judicial_role) { FactoryBot.create(:judicial_role) }

  let(:json_schema) { :judicial_role }


  describe "associations" do
    it { is_expected.to belong_to(:next_hearing).class_name("NextHearing").optional }
  end

  it { is_expected.to validate_presence_of(:judicialId) }
  it { is_expected.to validate_presence_of(:judicial_role_type) }

  it_has_behaviour "conforming to valid schema"
end
