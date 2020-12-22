# frozen_string_literal: true

RSpec.describe ContactNumber, type: :model do
  subject { contact_number }

  let(:contact_number) { FactoryBot.create(:contact_number) }

  let(:json_schema) { :contact_number }


  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
