# frozen_string_literal: true

RSpec.shared_examples "conforming to valid schema" do
  it "matches the given schema" do
    # binding.pry
    expect(subject.to_builder.target!).to match_json_schema(json_schema)
  end
end
