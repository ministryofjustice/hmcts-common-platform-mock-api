# frozen_string_literal: true

FactoryBot.define do
  factory :contact_number do
    home { '0500 993814' }
    work { '024 0862 0169' }
    mobile { '0378 383 9553' }
    primaryEmail { 'christian_renner@wildermanswift.name' }
    secondaryEmail { 'delbert@keeling.org' }
    fax { '024 0862 0169' }
  end
end
