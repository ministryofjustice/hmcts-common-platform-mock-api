# frozen_string_literal: true

class Offence < ApplicationRecord
  include BuilderMappable
  has_many :notified_pleas, dependent: :destroy
  has_many :indicated_pleas, dependent: :destroy
  has_many :allocation_decisions, dependent: :destroy
  has_many :pleas, dependent: :destroy
  has_many :verdicts, dependent: :destroy
  belongs_to :offence_facts, optional: true
  belongs_to :custody_time_limit, optional: true
  belongs_to :defendant, optional: true

  has_many :victims, class_name: 'Person', dependent: :destroy
  has_many :judicial_results, dependent: :destroy
  has_one :laa_reference, dependent: :destroy

  validates :offenceDefinitionId, presence: true
  validates :offenceCode, presence: true, length: { maximum: 8 }
  validates :offenceTitle, presence: true
  validates :wording, presence: true
  validates :startDate, presence: true

  accepts_nested_attributes_for :judicial_results, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :pleas, reject_if: :all_blank, allow_destroy: true

  def to_builder(hearing: nil)
    Jbuilder.new do |offence|
      offence.id id
      offence.offenceDefinitionId offenceDefinitionId
      offence.offenceCode offenceCode
      offence.offenceTitle offenceTitle
      offence.offenceTitleWelsh offenceTitleWelsh
      offence.offenceLegislation offenceLegislation
      offence.offenceLegislationWelsh offenceLegislationWelsh
      offence.modeOfTrial modeOfTrial
      offence.wording wording
      offence.wordingWelsh wordingWelsh
      offence.startDate startDate.to_date
      offence.endDate endDate&.to_date
      offence.arrestDate arrestDate&.to_date
      offence.chargeDate chargeDate&.to_date
      offence.laidDate laidDate&.to_date
      offence.dateOfInformation dateOfInformation&.to_date
      offence.orderIndex orderIndex
      offence.count count
      offence.convictionDate convictionDate.to_date
      offence.aquittalDate aquittalDate.to_date
      offence.victims array_builder(victims)
      offence.judicialResults array_builder(judicial_results)
      offence.isDiscontinued isDiscontinued
      offence.proceedingsConcluded proceedingsConcluded
      offence.offenceFacts offence_facts&.to_builder
      offence.laaApplnReference laa_reference&.to_builder
      offence.custodyTimeLimit custody_time_limit&.to_builder

      if hearing.present?
        offence.indicatedPlea indicated_plea_for_hearing(hearing)&.to_builder
        offence.allocationDecision allocation_decision_for_hearing(hearing)&.to_builder
        offence.plea plea_for_hearing(hearing)&.to_builder
        offence.verdict verdict_for_hearing(hearing)&.to_builder
      end
    end
  end

  private

  def indicated_plea_for_hearing(hearing)
    indicated_pleas.find_by(hearing: hearing)
  end

  def allocation_decision_for_hearing(hearing)
    allocation_decisions.find_by(hearing: hearing)
  end

  def plea_for_hearing(hearing)
    pleas.find_by(hearing: hearing)
  end

  def verdict_for_hearing(hearing)
    verdicts.find_by(hearing: hearing)
  end
end
