class AddHearingsToProsecutionCases < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|

      dir.up do
        prosecution_case_ids = execute("SELECT id from prosecution_cases WHERE id NOT IN (SELECT DISTINCT prosecution_case_id FROM prosecution_case_hearings)").flat_map(&:values)

        prosecution_case_ids.each do |prosecution_case_id|
          execute <<~SQL
            WITH hearing_type_ids as (
              INSERT INTO hearing_types
                (description, created_at, updated_at)
                VALUES ('Pre-Trial Review (PTR)', now(), now())
                RETURNING id
            ),

            hearing_ids as (
              INSERT INTO hearings
                ("jurisdictionType", "reportingRestrictionReason", "court_centre_id", "hearingLanguage", "hasSharedResults", "hearing_type_id", "isEffectiveTrial", "isBoxHearing", "created_at", "updated_at")
              VALUES ('CROWN', 'reporting restriction because...', 'bc4864ca-4b22-3449-9716-a8db1db89905', 'WELSH', 'false', (SELECT id from hearing_type_ids), false, false, now(), now()) RETURNING id
            ),

            case_hearing_ids as (
              INSERT INTO hearing_days (hearing_id, "sittingDay", "listingSequence", "listedDurationMinutes", created_at, updated_at)
              VALUES ((SELECT id from hearing_ids), '2019-10-23 16:19:15', 1, 1, NOW(), NOW()) RETURNING hearing_id
            )

            INSERT INTO prosecution_case_hearings (hearing_id, prosecution_case_id, created_at, updated_at)
            VALUES ((SELECT hearing_id from case_hearing_ids), '#{prosecution_case_id}', now(), now());
          SQL
        end
      end
    end
  end
end
