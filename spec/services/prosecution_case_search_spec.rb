# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProsecutionCaseSearch do
  subject { described_class.call(params) }

  let(:params) do
    ActionController::Parameters.new(prosecutionCaseReference: 'some reference')
  end

  let!(:prosecution_case) { FactoryBot.create(:prosecution_case) }

  it 'returns all ProsecutionCases' do
    expect(subject).to eq([prosecution_case])
  end

  context 'with invalid params' do
    let(:params) do
      ActionController::Parameters.new(random: 'value')
    end

    it 'raises an invalid params error' do
      expect do
        subject
      end.to raise_error(Errors::InvalidParams)
    end
  end
end
