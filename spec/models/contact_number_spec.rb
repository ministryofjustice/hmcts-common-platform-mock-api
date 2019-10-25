# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactNumber, type: :model do
  let(:contact_number) { FactoryBot.create(:contact_number) }

  let(:json_schema) { :contact_number }

  subject { contact_number }

  it_has_behaviour 'conforming to valid schema'

end
