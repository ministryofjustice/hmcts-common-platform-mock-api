# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/prosecution_cases/index', type: :view do
  before do
    assign(:prosecution_cases, ProsecutionCase.all.page)
  end

  it 'renders a list of prosecution_cases' do
    render
  end
end
