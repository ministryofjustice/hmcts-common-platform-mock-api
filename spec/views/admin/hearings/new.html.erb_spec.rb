# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/hearings/new", type: :view do
  let(:hearing) { Hearing.new }
  let(:prosecution_case) { FactoryBot.create(:prosecution_case) }

  before do
    assign(:hearing, hearing)
    assign(:prosecution_case, prosecution_case)
  end

  it "renders new hearing form" do
    render

    assert_select "form[action=?][method=?]", admin_prosecution_case_hearings_path(prosecution_case), "post" do
    end
  end
end
