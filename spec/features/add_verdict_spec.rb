require "support/when_authenticated"

RSpec.describe "adding a verdict against an offence", type: :feature do
  let(:prosecution_case) { hearing.prosecution_cases.first }
  let(:hearing) { FactoryBot.create(:hearing, :with_prosecution_case) }
  let(:offence) { prosecution_case.defendants.first.offences.first }

  describe "add verdict" do
    include_context "when authenticated"

    it "creates the new verdict" do
      visit "/admin/hearings/#{hearing.id}/edit"
      expect {
        click_link "add verdict"
      }.to change(Verdict, :count).by(1)
    end
  end
end
