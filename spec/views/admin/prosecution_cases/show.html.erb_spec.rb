# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/prosecution_cases/show', type: :view do
  before do
    @prosecution_case = assign(:prosecution_case, FactoryBot.create(:prosecution_case))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Alfredine Treutel Parker/)
  end
end
