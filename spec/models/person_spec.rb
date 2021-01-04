# frozen_string_literal: true

RSpec.describe Person, type: :model do
  subject { person }

  let(:person) { FactoryBot.create(:person) }
  let(:json_schema) { :person }

  describe "scopes" do
    describe ".by_name" do
      subject { described_class.by_name(name) }

      let(:name) { "John JD Doe" }

      let!(:person_one) { FactoryBot.create(:person, firstName: "John") }
      let!(:person_two) { FactoryBot.create(:person, firstName: "John", lastName: "Doe") }
      let!(:person_three) { FactoryBot.create(:person, firstName: "John", middleName: "JD", lastName: "Doe") }

      it { is_expected.to include(person_one) }
      it { is_expected.to include(person_two) }
      it { is_expected.to include(person_three) }

      context "omitting middleName" do
        let(:name) { "John Doe" }

        it { is_expected.to include(person_one) }
        it { is_expected.to include(person_two) }
        it { is_expected.to include(person_three) }
      end

      context "Single name search" do
        let(:name) { "Doe" }

        it { is_expected.not_to include(person_one) }
        it { is_expected.to include(person_two) }
        it { is_expected.to include(person_three) }
      end
    end

    describe ".by_date_of_birth" do
      subject { described_class.by_date_of_birth(date_of_birth) }

      let(:date_of_birth) { "2000-05-12" }

      let!(:person_one) { FactoryBot.create(:person, dateOfBirth: "2000-05-12") }
      let!(:person_two) { FactoryBot.create(:person, dateOfBirth: "2012-05-12") }

      it { is_expected.to include(person_one) }
      it { is_expected.not_to include(person_two) }
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:ethnicity).class_name("Ethnicity").optional }
    it { is_expected.to belong_to(:address).class_name("Address").optional }
    it { is_expected.to belong_to(:contact_number).class_name("ContactNumber").optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:lastName) }
    it { is_expected.to validate_presence_of(:gender) }

    it do
      is_expected.to validate_inclusion_of(:title)
        .in_array(%w[MR MRS MISS MS])
    end

    it do
      is_expected.to validate_inclusion_of(:gender)
        .in_array(%w[MALE FEMALE NOT_KNOWN NOT_SPECIFIED])
    end

    it do
      is_expected.to validate_inclusion_of(:documentationLanguageNeeds)
        .in_array(%w[ENGLISH WELSH])
    end
  end

  describe "#first_name" do
    subject { person.first_name }

    it { is_expected.to eq("Alfredine") }
  end

  describe "#middle_name" do
    subject { person.middle_name }

    it { is_expected.to eq("Treutel") }
  end

  describe "#last_name" do
    subject { person.last_name }

    it { is_expected.to eq("Parker") }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"

  context "with relationships" do
    let(:person) { FactoryBot.create(:person_with_relationships) }

    it_has_behaviour "conforming to valid schema"
  end
end
