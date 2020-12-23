# frozen_string_literal: true

RSpec.describe Applicant, type: :model do
  subject { applicant }

  let(:applicant) { FactoryBot.create(:applicant) }

  describe "associations" do
    it { is_expected.to belong_to(:applicant_counsel).class_name("ApplicantCounsel").optional }
  end

  it_has_a "realistic factory"
end
