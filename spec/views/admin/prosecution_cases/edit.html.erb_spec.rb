# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/prosecution_cases/edit", type: :view do
  let(:prosecution_case) { FactoryBot.create(:prosecution_case) }

  before do
    assign(:prosecution_case, prosecution_case)
  end

  it "renders the edit prosecution_case form" do
    render

    assert_select "form[action=?][method=?]", admin_prosecution_case_path(prosecution_case), "post" do
    end
  end
end
