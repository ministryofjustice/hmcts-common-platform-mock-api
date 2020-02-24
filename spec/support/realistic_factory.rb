# frozen_string_literal: true

RSpec.shared_examples 'realistic factory' do
  # By 'Realistic' we mean a factory that has all the attributes and relationships
  # conforming to the schema rather than static data.
  let(:random_object) { FactoryBot.create("realistic_#{subject.class.to_s.underscore}") }

  it { expect(random_object).to be_valid }
end
