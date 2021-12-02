# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/hearings/show", type: :view do
  let(:hearing) { FactoryBot.create(:hearing, :with_prosecution_case, court_centre_id: "6131bd34-33d9-3d1e-8152-8b5a2084f1bd") }
  let(:prosecution_case) { hearing.prosecution_cases.first }

  before do
    assign(:hearing, hearing)
    assign(:prosecution_case, prosecution_case)
  end

  it "renders the hearing court location" do
    render
    expect(rendered).to match(/Derby Crown Court/)
  end
end
