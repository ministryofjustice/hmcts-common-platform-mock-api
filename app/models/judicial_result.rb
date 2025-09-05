# frozen_string_literal: true

class JudicialResult < ApplicationRecord
  include BuilderMappable

  POST_HEARING_CUSTODY_STATUSES = %w[A B C L P R S U].freeze
  CATEGORIES = %w[FINAL INTERMEDIARY ANCILLARY].freeze

  belongs_to :court_clerk, class_name: "DelegatedPowers", optional: true
  belongs_to :delegated_powers, optional: true
  belongs_to :four_eyes_approval, class_name: "DelegatedPowers", optional: true
  belongs_to :next_hearing, optional: true
  belongs_to :hearing
  belongs_to :defendant, optional: true
  belongs_to :offence, optional: true
  belongs_to :court_application, optional: true

  has_many :user_groups
  has_many :judicial_result_prompts, dependent: :destroy

  validates :label, presence: true
  validates :isAdjournmentResult, inclusion: [true, false]
  validates :isFinancialResult, inclusion: [true, false]
  validates :isConvictedResult, inclusion: [true, false]
  validates :isAvailableForCourtExtract, inclusion: [true, false]
  validates :orderedDate, presence: true
  validates :category, presence: true, inclusion: CATEGORIES
  validates :orderedHearingId, presence: true

  accepts_nested_attributes_for :next_hearing, reject_if: :all_blank, allow_destroy: true

  def to_builder
    Jbuilder.new do |judicial_result|
      judicial_result.judicialResultId judicialResultId
      judicial_result.judicialResultTypeId judicialResultTypeId
      judicial_result.orderedHearingId hearing_id
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
      judicial_result.rank rank
      judicial_result.orderedDate orderedDate.to_date
      judicial_result.postHearingCustodyStatus postHearingCustodyStatus if postHearingCustodyStatus.present?
      judicial_result.lastSharedDateTime lastSharedDateTime
      judicial_result.terminatesOffenceProceedings terminatesOffenceProceedings
      judicial_result.courtClerk court_clerk.to_builder if court_clerk.present?
      judicial_result.delegatedPowers delegated_powers.to_builder if delegated_powers.present?
      judicial_result.fourEyesApproval four_eyes_approval.to_builder if four_eyes_approval.present?
      judicial_result.approvedDate approvedDate.to_date
      judicial_result.usergroups user_groups.map(&:group)
      judicial_result.category category
      judicial_result.nextHearing next_hearing.to_builder if next_hearing.present?
      judicial_result.judicialResultPrompts array_builder(judicial_result_prompts)
    end
  end

  def defendant_judicial_result
    @defendant_judicial_result ||= DefendantJudicialResult.new(
      master_defendant_id: defendant&.masterDefendantId,
      judicial_result: self,
    )
  end
end
