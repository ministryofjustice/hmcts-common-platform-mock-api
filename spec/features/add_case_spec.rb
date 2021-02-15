# frozen_string_literal: true

require "support/when_authenticated"

RSpec.describe "adding a new offence to prosecution case ", type: :feature do
  let(:defendant) { FactoryBot.create(:defendant) }

  describe "add offence" do
    include_context "when authenticated"

    it "creates the new offence", js: true do
      visit "/admin/defendants/#{defendant.id}"
      click_link "Add offence"
      expect {
        click_button "Create Offence"
      }.to change(Offence, :count).by(1)
    end
  end
end
