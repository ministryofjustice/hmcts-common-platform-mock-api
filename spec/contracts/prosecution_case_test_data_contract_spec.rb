# frozen_string_literal: true

require "rspec"

RSpec.describe ProsecutionCaseTestDataContract do
  subject { described_class.new.call(hash_for_validation) }

  context "without a is_guilty parameter" do
    let(:hash_for_validation) { { result_code: 1 } }

    it { is_expected.not_to be_a_success }
  end

  context "with invalid is_guilty parameter" do
    let(:hash_for_validation) { { is_guilty: "invalid", result_code: 1 } }

    it { is_expected.not_to be_a_success }
  end

  context "without a result_code parameter" do
    let(:hash_for_validation) { { is_guilty: true } }

    it { is_expected.not_to be_a_success }
  end

  context "with invalid result_code parameter" do
    let(:hash_for_validation) { { is_guilty: true, result_code: "string" } }

    it { is_expected.not_to be_a_success }
  end

  context "with negative result_code parameter" do
    let(:hash_for_validation) { { is_guilty: true, result_code: -1 } }

    it { is_expected.not_to be_a_success }
  end

  context "without any parameters" do
    let(:hash_for_validation) { {} }

    it { is_expected.not_to be_a_success }
  end

  context "with valid parameters" do
    let(:hash_for_validation) { { is_guilty: true, result_code: 1 } }

    it { is_expected.to be_a_success }
  end
end
