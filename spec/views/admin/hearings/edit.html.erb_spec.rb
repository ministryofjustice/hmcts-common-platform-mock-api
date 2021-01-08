# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/hearings/edit", type: :view do
  let(:hearing) { FactoryBot.create(:hearing, :with_prosecution_case) }

  before do
    assign(:hearing, hearing)
  end

  it "renders the edit hearing form" do
    render

    assert_select "form[action=?][method=?]", admin_hearing_path(hearing), "post" do
    end
  end
end
