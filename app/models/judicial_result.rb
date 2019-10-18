class JudicialResult < ApplicationRecord
  belongs_to :court_clerk, class_name: 'DelegatedPowers', optional: true
  belongs_to :delegated_powers, optional: true
  belongs_to :four_eyes_approval, class_name: 'DelegatedPowers', optional: true
  belongs_to :next_hearing, optional: true
  belongs_to :duration_element, class_name: 'JudicialResultPromptDurationElement', optional: true

  has_many :user_groups
  has_many :judicial_result_prompts


  validates :orderedHearingId, presence: true
  validates :label, presence: true
  validates :isAdjournmentResult, inclusion: [true, false]
  validates :isFinancialResult, inclusion: [true, false]
  validates :isConvictedResult, inclusion: [true, false]
  validates :isAvailableForCourtExtract, inclusion: [true, false]
  validates :orderedDate, presence: true
  validates :category, presence: true, inclusion: %w(FINAL INTERMEDIARY ANCILLARY)
  validates :resultText, presence: true
  validates :terminatesOffenceProceedings, inclusion: [true, false]
  validates :isLifeDuration, inclusion: [true, false]
  validates :isPublishedAsAPrompt, inclusion: [true, false]
  validates :isExcludedFromResults, inclusion: [true, false]
  validates :isAlwaysPublished, inclusion: [true, false]
  validates :isUrgent, inclusion: [true, false]
  validates :isD20, inclusion: [true, false]

  def to_builder
    Jbuilder.new do |judicial_result|
      judicial_result.judicialResultId judicialResultId
      judicial_result.orderedHearingId orderedHearingId
      judicial_result.label label
      judicial_result.welshLabel welshLabel
      judicial_result.isAdjournmentResult isAdjournmentResult
      judicial_result.isFinancialResult isFinancialResult
      judicial_result.isConvictedResult isConvictedResult
      judicial_result.isAvailableForCourtExtract isAvailableForCourtExtract
      judicial_result.isDeleted isDeleted
      judicial_result.amendmentReasonId amendmentReasonId
      judicial_result.amendmentReason amendmentReason
      judicial_result.amendmentDate amendmentDate.to_date
      judicial_result.qualifier qualifier
      judicial_result.resultText resultText
      judicial_result.cjsCode cjsCode
      judicial_result.postHearingCustodyStatus postHearingCustodyStatus
      judicial_result.rank rank
      judicial_result.orderedDate orderedDate.to_date
      judicial_result.lastSharedDateTime lastSharedDateTime
      judicial_result.terminatesOffenceProceedings terminatesOffenceProceedings
      judicial_result.isLifeDuration isLifeDuration
      judicial_result.isPublishedAsAPrompt isPublishedAsAPrompt
      judicial_result.isExcludedFromResults isExcludedFromResults
      judicial_result.isAlwaysPublished isAlwaysPublished
      judicial_result.isUrgent isUrgent
      judicial_result.isD20 isD20
      judicial_result.courtClerk court_clerk.to_builder if court_clerk.present?
      judicial_result.delegatedPowers delegated_powers.to_builder if delegated_powers.present?
      judicial_result.fourEyesApproval four_eyes_approval.to_builder if four_eyes_approval.present?
      judicial_result.approvedDate approvedDate.to_date
      judicial_result.usergroups Jbuilder.new.array! user_groups_builder
      judicial_result.category category
      judicial_result.nextHearing next_hearing.to_builder if next_hearing.present?
      judicial_result.durationElement duration_element.to_builder if duration_element.present?
      judicial_result.judicialResultPrompts Jbuilder.new.array! judicial_result_prompts_builder if judicial_result_prompts.present?
    end
  end

  private
    def judicial_result_prompts_builder
      judicial_result_prompts.map do |judicial_result_prompt|
        judicial_result_prompt.to_builder.attributes!
      end
    end

    def user_groups_builder
      user_groups.map(&:group)
    end
end
