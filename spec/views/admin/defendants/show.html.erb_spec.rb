# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/defendants/show.html.erb", type: :view do
  before do
    @defendant = assign(:defendant, FactoryBot.create(:defendant))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Alfredine Treutel Parker/)
  end
end
