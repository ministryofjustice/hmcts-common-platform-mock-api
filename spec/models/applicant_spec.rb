# frozen_string_literal: true

RSpec.describe Applicant, type: :model do
  let(:applicant) { FactoryBot.create(:applicant) }

  subject { applicant }

  describe 'associations' do
    it { should belong_to(:applicant_counsel).class_name('ApplicantCounsel').optional }
  end
end
