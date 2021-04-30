require "rails_helper"

RSpec.describe FutureSummonsHearing, type: :model do
  subject { future_summons_hearing }

  let(:future_summons_hearing) { FactoryBot.create(:future_summons_hearing) }

  let(:json_schema) { :future_summons_hearing }

  describe "associations" do
    it { is_expected.to have_many(:judicial_roles).class_name("JudicialRole") }
  end

  describe "validations" do
    it "has a key 'start date' in the column 'week_commencing_date'" do
      expect(future_summons_hearing.week_commencing_date).to have_key("startDate")
    end
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
