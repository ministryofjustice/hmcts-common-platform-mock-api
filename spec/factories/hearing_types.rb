# frozen_string_literal: true

FactoryBot.define do
  factory :hearing_type do
    description do
      [
        'Plea and Trial Prepation (PTP)',
        'Trial (TRL)',
        'Pre-Trial Review (PTR)',
        'Application to Break Fixture (BFA)',
        'Mention - Defendant to Attend (MDA)'
      ].sample
    end

    code { '12D10JAS' }
  end
end
