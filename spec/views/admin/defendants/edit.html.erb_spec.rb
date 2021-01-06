# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/defendants/edit.html.erb", type: :view do
  let(:defendant) { FactoryBot.create(:defendant) }

  before do
    assign(:defendant, defendant)
  end

  it "renders the edit defendant form" do
    render

    assert_select "form[action=?][method=?]", admin_defendant_path(defendant), "post" do
    end
  end
end
