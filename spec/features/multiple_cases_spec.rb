# frozen_string_literal: true

require "support/when_authenticated"

RSpec.describe "adding a new prosecution case to a court applicaiton", type: :feature do
  include_context "when authenticated"

  it "lets me walk through" do
    visit root_path
    click_on "New Prosecution Case"
    click_on "Create Prosecution case"
    first_pc = ProsecutionCase.first
    within :table, "Defendants" do
      click_on "Show"
    end

    click_on "Add prosecution case"
    click_on "Create Prosecution case"
    second_pc = ProsecutionCase.where.not(id: first_pc.id).first

    expect(first_pc.defendants.first.masterDefendantId).to eq second_pc.defendants.first.masterDefendantId
    expect(first_pc.defendants.first.defendable.person.firstName).to eq second_pc.defendants.first.defendable.person.firstName

    within :table, "Defendants" do
      click_on "Show"
    end

    click_on "Add court application"
    click_on "Show"

    expect(page).to have_content "Prosecution cases\n#{second_pc.prosecution_case_identifier.caseURN}"
    expect(page).to have_content "Available prosecution cases\n#{first_pc.prosecution_case_identifier.caseURN}"

    click_on "Associate"
    expect(page).to have_content "Case associated"

    application = CourtApplication.first
    expect(application.prosecution_cases.to_set).to eq [second_pc, first_pc].to_set
    expect(application.defendant.masterDefendantId).to eq first_pc.defendants.first.masterDefendantId
  end
end
