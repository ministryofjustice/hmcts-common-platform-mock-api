require "support/when_authenticated"

RSpec.describe "adding a verdict against an offence", type: :feature do
  let(:prosecution_case) { hearing.prosecution_cases.first }
  let(:hearing) { FactoryBot.create(:hearing, :with_prosecution_case) }
  let(:hearing_two) { FactoryBot.create(:hearing, id: "fb5eca66-4bf2-4630-b312-74d83b01c0ae") }

  describe "add verdict" do
    include_context "when authenticated"

    it "creates the new verdict" do
      visit "/admin/hearings/#{hearing.id}/edit"
      click_link "add verdict"
      
      expect(page).to have_text("Verdict Date")
    end

    context "when a verdict has been added" do
      it "does not allow the creation of another verdict" do
        visit "/admin/hearings/#{hearing.id}/edit"
        click_link "add verdict"

        expect(page).not_to have_link("add verdict")
      end

      it "does not allow the creation of another verdict on another hearing for the same offence" do
        prosecution_case.hearings << hearing_two
        visit "/admin/hearings/#{hearing.id}/edit"
        click_link "add verdict"
        click_button "Update Hearing"
        visit "/admin/hearings/#{hearing_two.id}/edit"

        expect(page).not_to have_text("Verdict Date")
        expect(page).not_to have_link("add verdict")
      end
    end
  end
end
