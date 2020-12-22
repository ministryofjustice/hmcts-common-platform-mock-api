# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/prosecution_cases/new", type: :view do
  before do
    assign(:prosecution_case, ProsecutionCase.new)
  end

  it "renders new prosecution_case form" do
    render

    assert_select "form[action=?][method=?]", admin_prosecution_cases_path, "post" do
    end
  end
end
