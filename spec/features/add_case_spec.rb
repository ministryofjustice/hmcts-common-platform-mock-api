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
end
