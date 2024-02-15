# frozen_string_literal: true

class ProsecutionCaseTestDataContract < Dry::Validation::Contract
  json do
    required(:is_guilty).value(:bool)
    required(:result_code).value(:integer)
  end

  rule(:result_code) do
    key.failure("must be a positive integer value") if value.negative?
  end
end
