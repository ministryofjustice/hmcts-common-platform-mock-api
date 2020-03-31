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
  print "[CREATE][PROSECUTION_CASE] #{CASE1[:URN]}"
  case1 = FactoryBot.create(
    :realistic_prosecution_case,
    prosecution_case_identifier: FactoryBot.create(:realistic_prosecution_case_identifier, caseURN: CASE1[:URN])
  )
  FactoryBot.create_list(:realistic_defendant, 2, prosecution_case: case1)

  person_defendant1 = FactoryBot.create(:realistic_person_defendant, person: person)
  FactoryBot.create(:realistic_defendant, defendable: person_defendant1, prosecution_case: case1)
  puts " #{ICONS[:success]}"

  # create specific case with 2 random defendants plus Jammy Dodger
  print "[CREATE][PROSECUTION_CASE] #{CASE2[:URN]}"
  case2 = FactoryBot.create(
    :realistic_prosecution_case,
    prosecution_case_identifier: FactoryBot.create(:realistic_prosecution_case_identifier, caseURN: CASE2[:URN])
  )
  FactoryBot.create_list(:realistic_defendant, 1, prosecution_case: case2)

  person_defendant2 = FactoryBot.create(:realistic_person_defendant, person: person)
  FactoryBot.create(:realistic_defendant, defendable: person_defendant2, prosecution_case: case2)
  puts " #{ICONS[:success]}"
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
  puts "No cases matching #{case_urn} found #{ICONS[:failure]}" if pcases.empty?

  pcases.each do |pcase|
    pcase.defendants.each do |defendant|
      defended_item = defendant.defendable
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
