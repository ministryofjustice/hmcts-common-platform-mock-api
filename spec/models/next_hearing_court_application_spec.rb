# frozen_string_literal: true

RSpec.describe NextHearingCourtApplication, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:next_hearing).class_name("NextHearing").optional }
  end
end
