# frozen_string_literal: true

class CourtApplicationType < ApplicationRecord
  JURISDICTION_TYPES = %w[MAGISTRATES CROWN EITHER].freeze
  LINK_TYPES = %w[STANDALONE LINKED NEITHER].freeze
  RECIPIENT_TYPES = %w[APPLICANT RESPONDENT].freeze
  TEMPLATE_TYPES = %w[GENERIC_SUMMONS].freeze

  COURT_APPLICATION_TYPES = YAML.load_file(
    Rails.root.join("lib/data/supported_court_application_types.yml"),
  ).freeze

  # This disables STI to allow us to use the column name 'type'.
  # In this model 'type' is synonymous with 'application type'.
  self.inheritance_column = nil

  has_one :court_application, inverse_of: :court_application_type

  validates :type, presence: true
  validates :category_code, presence: true
  validates :linkType, presence: true, inclusion: LINK_TYPES
  validates :jurisdiction, presence: true, inclusion: JURISDICTION_TYPES
  validates :summons_template_type, presence: true
  validates :breach_type, presence: true
  validates :appeal_flag, presence: true
  validates :applicant_appellant_flag, presence: true
  validates :plea_applicable_flag, presence: true
  validates :commr_of_oath_flag, presence: true
  validates :court_of_appeal_flag, presence: true
  validates :court_extract_avl_flag, presence: true
  validates :prosecutor_third_party_flag, presence: true
  validates :spi_out_applicable_flag, presence: true
  validates :offence_active_order, presence: true

  before_save do
    unless code.nil?
      self.category_code = COURT_APPLICATION_TYPES[code]&.fetch("category", nil)
      self.type = COURT_APPLICATION_TYPES[code]&.fetch("title", nil)
    end
  end

  def to_builder
    Jbuilder.new do |court_application_type|
      court_application_type.id id
      court_application_type.code code
      court_application_type.legislation legislation
      court_application_type.validFrom valid_from
      court_application_type.listingNotifTemplate listing_notif_template
      court_application_type.boxworkNotifTemplate boxwork_notif_template
      court_application_type.typeWelsh type_welsh
      court_application_type.legislationWelsh legislation_welsh
      court_application_type.hearingCode hearing_code
      court_application_type.linkType linkType
      court_application_type.summonsTemplateType summons_template_type
      court_application_type.type type
      court_application_type.appealFlag appeal_flag
      court_application_type.categoryCode category_code
      court_application_type.jurisdiction jurisdiction
      court_application_type.breachType breach_type
      court_application_type.applicantAppellantFlag applicant_appellant_flag
      court_application_type.pleaApplicableFlag plea_applicable_flag
      court_application_type.commrOfOathFlag commr_of_oath_flag
      court_application_type.courtOfAppealFlag court_of_appeal_flag
      court_application_type.courtExtractAvlFlag court_extract_avl_flag
      court_application_type.prosecutorThirdPartyFlag prosecutor_third_party_flag
      court_application_type.spiOutApplicableFlag spi_out_applicable_flag
      court_application_type.offenceActiveOrder offence_active_order
    end
  end
end
