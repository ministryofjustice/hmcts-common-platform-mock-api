# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/prosecution_cases/show", type: :view do
  before do
    @prosecution_case = assign(:prosecution_case, FactoryBot.create(:prosecution_case))
    @env_options = [%w[Development dev], %w[Test test], %w[Stage stage]]
    @default_env = "dev"
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Alfredine Treutel Parker/)
  end

  it "shows environment selection box with correct default value" do
    render
    expect(rendered).to have_select("environment_select", selected: "Development")
  end
end
