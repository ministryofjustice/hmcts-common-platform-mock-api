# frozen_string_literal: true

require_relative "demo_data_helper"
include DemoDataHelper

namespace :mock do
  namespace :demodata do
    desc "create existing demo data"
    task load: :environment do
      create_prosecution_cases
    end

    desc "remove existing demo data"
    task unload: :environment do
      destroy_prosecution_case(CASE1[:URN])
      destroy_prosecution_case(CASE2[:URN])
    end
  end
end

CASE1 = { URN: "TEST12345" }.freeze
CASE2 = { URN: "TEST54321" }.freeze
ICONS = {
  success: "\u{2705}",
  failure: "\u{274E}",
}.freeze

# create bear minimum reflection of possible
# data - 2 cases with "known" attributes
# and a cross-case defendant, for easy
# querying via UI and covering possible search
# scenarios.
#
def create_prosecution_cases
  # create person 'Jammy Dodger'
  person = create_person

  # create specific case with 3 random defendants plus Jammy Dodger
  case1 = create_case_and_defendants(urn: CASE1[:URN], additional_defendant_count: 2)
  defendant1 = create_defendant_for(prosecution_case: case1, person: person)
  create_allocation_decision_for(defendant: defendant1)
  create_pleas_for(defendant: defendant1)
  create_hearings_for(prosecution_case: case1, defendant: defendant1)

  # create another case with 2 random defendants and jammy dodger
  case2 = create_case_and_defendants(urn: CASE2[:URN], additional_defendant_count: 1)
  create_defendant_for(prosecution_case: case2, person: person)

  pp case_details_hash(CASE1[:URN])
end

def create_person
  print "[CREATE][PERSON]"
  person = FactoryBot.create(
    :realistic_person,
    title: "MR",
    firstName: "Jammy",
    middleName: "",
    lastName: "Dodger",
    dateOfBirth: "21-MAY-1987".to_date,
    gender: "MALE",
    nationalInsuranceNumber: "JC123456A",
  )
  puts " #{ICONS[:success]}"

  person
end

def create_case_and_defendants(urn:, additional_defendant_count: 1)
  print "[CREATE][PROSECUTION_CASE] #{urn}"
  prosecution_case = FactoryBot.create(
    :realistic_prosecution_case,
    prosecution_case_identifier: FactoryBot.create(:realistic_prosecution_case_identifier, caseURN: urn),
  )
  FactoryBot.create_list(:realistic_defendant, additional_defendant_count, prosecution_case: prosecution_case)
  puts " #{ICONS[:success]}"

  prosecution_case
end

def create_defendant_for(prosecution_case:, person:)
  print "[CREATE][DEFENDANT] on #{prosecution_case.prosecution_case_identifier.caseURN}"
  person_defendant = FactoryBot.create(:realistic_person_defendant, person: person)
  defendant = FactoryBot.create(:realistic_defendant, defendable: person_defendant, prosecution_case: prosecution_case)
  puts " #{ICONS[:success]}"
  defendant
end

def create_allocation_decision_for(defendant:)
  print "[CREATE][DEFENDANT][OFFENCE][ALLOCATION_DECISION] #{defendant.prosecution_case.prosecution_case_identifier.caseURN}"
  offence = defendant.offences.first
  offence.allocation_decisions << FactoryBot.create(:realistic_allocation_decision)
  offence.save!
  puts " #{ICONS[:success]}"
end

def create_pleas_for(defendant:)
  print "[CREATE][DEFENDANT][OFFENCE][PLEAS] #{CASE1[:URN]}"
  pc = defendant.prosecution_case

  defendant.offences.each do |offence|
    offence.pleas.create!(pleaDate: pc.hearings.first.hearing_days.first.sittingDay,
                          pleaValue: %w[NO_PLEA NOT_GUILTY].sample, hearing: pc.hearings.first)
    offence.pleas.create!(pleaDate: pc.hearings.last.hearing_days.last.sittingDay,
                          pleaValue: %w[GUILTY UNFIT_TO_PLEAD].sample, hearing: pc.hearings.last)
    offence.save!
  end
  puts " #{ICONS[:success]}"
end

def create_hearings_for(prosecution_case:, defendant:)
  urn = prosecution_case.prosecution_case_identifier.caseURN

  print "[CREATE][HEARINGS] for #{urn}"
  prosecution_case.hearings.reload.destroy_all
  prosecution_case.hearings << FactoryBot.create_list(:hearing, 3)
  puts " #{ICONS[:success]}"

  print "[CREATE][DEFENCE_COUNSELS] for #{urn}"
  defence_counsels = FactoryBot.create_list(:defence_counsel, 2, defendant: defendant)
  puts " #{ICONS[:success]}"

  prosecution_case.hearings.each do |hearing|
    print "[CREATE][HEARINGS][DEFENCE_COUNSELS] for #{urn}"
    hearing.resulted = true
    hearing.defence_counsels << defence_counsels
    hearing.save!
    puts " #{ICONS[:success]}"

    print "[CREATE][HEARINGS][HEARING_DAYS] for #{urn}"
    base_date = "2019-10-23 00:00:00".to_datetime
    hearing.hearing_days << FactoryBot.create(:hearing_day, sittingDay: (base_date + 1.day + 8.hours + 30.minutes).to_s)
    hearing.hearing_days << FactoryBot.create(:hearing_day, sittingDay: (base_date + 2.days + 10.hours + 45.minutes).to_s)
    hearing.save!
    puts " #{ICONS[:success]}"

    print "[CREATE][HEARINGS][HEARING_DAYS][HEARING_EVENT] for #{urn}"
    hearing.hearing_days.each do |hearing_day|
      10.times do |idx|
        hearing_day.events << FactoryBot.create(:hearing_event,
                                                eventTime: hearing_day.sittingDay + idx.hours,
                                                recordedLabel: "Hearing event #{idx}")
      end
    end
    hearing.save!

    puts " #{ICONS[:success]}"
  end
end

def destroy_prosecution_case(case_urn)
  pcases = prosecution_cases_by_reference(case_urn)
  puts pcases.empty? ? "No cases matching #{case_urn} found #{ICONS[:failure]}" : "Cases matching #{case_urn} found #{ICONS[:success]}"

  pcases.each do |pcase|
    pcase.defendants.each do |defendant|
      defended_item = defendant.defendable
      defended_item ||= defendant.defence_organisation
      next unless defended_item

      print "[DESTROY][DEFENDED ITEM] #{humanize_defended_item(defended_item)}"
      defended_item.destroy!
      puts " #{ICONS[:success]}"
    end

    print "[DESTROY][PROSECUTION_CASE] #{humanize_prosecution_case(pcase)}"
    pcase.destroy!
    puts " #{ICONS[:success]}"
  end
end
