# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/prosecution_cases/index', type: :view do
  before do
    assign(:prosecution_cases, FactoryBot.create_list(:prosecution_case, 2))
  end

  it 'renders a list of prosecution_cases' do
    render
  end
end
