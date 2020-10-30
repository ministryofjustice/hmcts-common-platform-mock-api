# frozen_string_literal: true

require_relative 'demo_data_helper'
include DemoDataHelper

namespace :mock do
  namespace :demodata do
    desc 'create existing demo data'
    task load: :environment do
      create_prosecution_cases
    end

    desc 'remove existing demo data'
    task unload: :environment do
      destroy_prosecution_case(CASE1[:URN])
      destroy_prosecution_case(CASE2[:URN])
    end
  end
end

CASE1 = { URN: 'TEST12345' }.freeze
CASE2 = { URN: 'TEST54321' }.freeze
ICONS = {
  success: "\u{2705}",
  failure: "\u{274E}"
}.freeze

# create bear minimum reflection of possible
# data - 2 cases with "known" attributes
# and a cross-case defendant, for easy
# querying via UI and covering possible search
# scenarios.
#
def create_prosecution_cases
  # create person 'Jammy Dodger'
  print '[CREATE][PERSON]'
  person = create_person
  puts " #{ICONS[:success]}"

  # create specific case with 3 random defendants plus Jammy Dodger
  # - add allocation decisions to jammy dodger on offence
  print "[CREATE][PROSECUTION_CASE] #{CASE1[:URN]}"
  case1 = FactoryBot.create(
    :realistic_prosecution_case,
    prosecution_case_identifier: FactoryBot.create(:realistic_prosecution_case_identifier, caseURN: CASE1[:URN])
  )
  FactoryBot.create_list(:realistic_defendant, 2, prosecution_case: case1)
  puts " #{ICONS[:success]}"

  print "[CREATE][DEFENDANT] on #{CASE1[:URN]}"
  person_defendant1 = FactoryBot.create(:realistic_person_defendant, person: person)
  defendant1 = FactoryBot.create(:realistic_defendant, defendable: person_defendant1, prosecution_case: case1)
  puts " #{ICONS[:success]}"

  print "[CREATE][OFFENCE][ALLOCATION_DECISION] #{CASE1[:URN]}"
  offence = defendant1.offences.first
  offence.allocation_decisions << FactoryBot.create(:realistic_allocation_decision)
  offence.save!
  puts " #{ICONS[:success]}"

  print "[CREATE][HEARINGS] for #{CASE1[:URN]}"
  case1.hearings.reload.destroy_all
  case1.hearings << FactoryBot.create_list(:hearing, 3)
  puts " #{ICONS[:success]}"

  print "[CREATE][DEFENCE_COUNSELS] for #{CASE1[:URN]}"
  defence_counsels = FactoryBot.create_list(:defence_counsel, 2)
  puts " #{ICONS[:success]}"

  case1.hearings.each do |hearing|
    print "[CREATE][HEARINGS][DEFENCE_COUNSELS] for #{CASE1[:URN]}"
    hearing.resulted = true
    hearing.defence_counsels << defence_counsels
    hearing.save!
    puts " #{ICONS[:success]}"

    print "[CREATE][HEARINGS][HEARING_DAYS] for #{CASE1[:URN]}"
    base_date = '2019-10-23 00:00:00'.to_datetime
    hearing.hearing_days << FactoryBot.create(:hearing_day, sittingDay: (base_date + 1.day + 8.hours + 30.minutes).to_s)
    hearing.hearing_days << FactoryBot.create(:hearing_day, sittingDay: (base_date + 2.day + 10.hours + 45.minutes).to_s)
    hearing.save!
    puts " #{ICONS[:success]}"

    print "[CREATE][HEARINGS][HEARING_DAYS][HEARING_EVENT] for #{CASE1[:URN]}"
    hearing.hearing_days.each do |hearing_day|
      10.times do |idx|
        hearing_day.events << FactoryBot.create(:hearing_event, eventTime: hearing_day.sittingDay + idx.hours, recordedLabel: "Hearing event #{idx}")
      end
    end
    hearing.save!
    puts " #{ICONS[:success]}"
  end

  # create another case with 2 random defendants plus Jammy Dodger
  print "[CREATE][PROSECUTION_CASE] #{CASE2[:URN]}"
  case2 = FactoryBot.create(
    :realistic_prosecution_case,
    prosecution_case_identifier: FactoryBot.create(:realistic_prosecution_case_identifier, caseURN: CASE2[:URN])
  )
  FactoryBot.create_list(:realistic_defendant, 1, prosecution_case: case2)

  person_defendant2 = FactoryBot.create(:realistic_person_defendant, person: person)
  FactoryBot.create(:realistic_defendant, defendable: person_defendant2, prosecution_case: case2)
  puts " #{ICONS[:success]}"

  pp case_details_hash(CASE1[:URN])
end

def create_person
  FactoryBot.create(
    :realistic_person,
    title: 'MR',
    firstName: 'Jammy',
    middleName: '',
    lastName: 'Dodger',
    dateOfBirth: '21-MAY-1987'.to_date,
    gender: 'MALE',
    nationalInsuranceNumber: 'JC123456A'
  )
end

def destroy_prosecution_case(case_urn)
  pcases = prosecution_cases_by_reference(case_urn)
  puts pcases.empty? ? "No cases matching #{case_urn} found #{ICONS[:failure]}" : "Cases matching #{case_urn} found #{ICONS[:success]}"

  pcases.each do |pcase|
    pcase.defendants.each do |defendant|
      defended_item = defendant.defendable
      defended_item = defendant.defence_organisation unless defended_item
      next unless defended_item

      print "[DESTROY][DEFENDED ITEM] #{humanize_defended_item(defended_item)}"
      defended_item.destroy
      puts " #{ICONS[:success]}"
    end

    print "[DESTROY][PROSECUTION_CASE] #{humanize_prosecution_case(pcase)}"
    pcase.destroy
    puts " #{ICONS[:success]}"
  end
end
