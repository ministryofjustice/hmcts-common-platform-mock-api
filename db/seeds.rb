# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

ModeOfTrialReason.create(seq_number: 110, reason_code: 8, reason_description: "Offence triable only by court martial")
ModeOfTrialReason.create(seq_number: 100, reason_code: 2, reason_description: "Indictable-only offence")
ModeOfTrialReason.create(seq_number: 60, reason_code: 7, reason_description: "No mode of Trial - Either way offence")
ModeOfTrialReason.create(seq_number: 40, reason_code: 3, reason_description: "Defendant consents to summary trial")
ModeOfTrialReason.create(seq_number: 130, reason_code: 10, reason_description: "Commanding Officer orders trial by court martial")
ModeOfTrialReason.create(seq_number: 120, reason_code: 9, reason_description: "Defendant chooses trial by court martial 1")
ModeOfTrialReason.create(seq_number: 30, reason_code: 4, reason_description: "Defendant elects trial by jury")
ModeOfTrialReason.create(seq_number: 90, reason_code: 1, reason_description: "Summary-only offence")
ModeOfTrialReason.create(seq_number: 70, reason_code: 2, reason_description: "Youth - offence triable on indictment only (homicide / relevant firearms / dangerousness)")
ModeOfTrialReason.create(seq_number: 80, reason_code: 5, reason_description: "Youth - Court directs trial by jury (grave crime)")
ModeOfTrialReason.create(seq_number: 50, reason_code: 6, reason_description: "Low value offence triable summarily only")
ModeOfTrialReason.create(seq_number: 10, reason_code: 2, reason_description: "Indictable only (previous convictions / relevant firearms offence)")
ModeOfTrialReason.create(seq_number: 20, reason_code: 5, reason_description: "Court directs trial by jury")
