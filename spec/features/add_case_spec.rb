# frozen_string_literal: true

require "support/when_authenticated"

RSpec.describe "adding a new offence to prosecution case ", type: :feature do
  let(:prosecution_case) { FactoryBot.create(:realistic_prosecution_case) }

  describe "add offence" do
    include_context "when authenticated"

    it "creates the new offence", js: true do
      visit "/admin/prosecution_cases/#{prosecution_case.id}/edit"
      click_link "add offence"
      expect {
        click_button "Update Prosecution case"
      }.to change(Offence, :count).by(1)
    end
  end

  describe "next hearing" do
    it "creates a next hearing" do
      visit "/admin/prosecution_cases/new"
      expect { click_button "Create Prosecution case" }.to change(NextHearing, :count).by(1)
    end

    it "updates a next hearing" do
      visit "/admin/prosecution_cases/#{prosecution_case.id}/edit"
      fill_in "Estimatedminutes", :with => "2"
      click_button "Update Prosecution case"

      expect(page).to have_text("Prosecution case was successfully updated.")
    end
  end
end
