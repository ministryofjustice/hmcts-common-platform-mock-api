require 'rails_helper'

RSpec.shared_examples 'conforming to valid schema' do
  it 'matches the given schema' do
    expect(subject.to_builder.target!).to match_json_schema(json_schema)
  end
end