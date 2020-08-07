# frozen_string_literal: true

module Admin
  # rubocop:disable Metrics/ClassLength
  class ProsecutionCasesController < Admin::ApplicationController
    before_action :set_prosecution_case, only: %i[show edit update destroy result]

    def index
      @prosecution_cases = ProsecutionCase.all
    end

    def show; end

    def new
      @prosecution_case = FactoryBot.build(:realistic_prosecution_case)
    end

    def edit; end

    def create
      @prosecution_case = ProsecutionCase.new(prosecution_case_params)

      if @prosecution_case.save
        redirect_to [:admin, @prosecution_case], notice: 'Prosecution case was successfully created.'
      else
        render :new
      end
    end

    def update
      if @prosecution_case.update(prosecution_case_params)
        redirect_to [:admin, @prosecution_case], notice: 'Prosecution case was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @prosecution_case.destroy
      redirect_to admin_prosecution_cases_url, notice: 'Prosecution case was successfully destroyed.'
    end

    def result
      if HearingResulter.call(hearing_id: params[:hearing_id], publish_to: params[:publish_to])
        redirect_to [:admin, @prosecution_case], notice: 'Hearing was successfully resulted.'
      else
        render :edit
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_prosecution_case
      @prosecution_case = ProsecutionCase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prosecution_case_params
      params.require(:prosecution_case).permit(:originatingOrganisation,
                                               :initiationCode,
                                               :caseStatus,
                                               :statementOfFacts,
                                               :statementOfFactsWelsh,
                                               :breachProceedingsPending,
                                               :appealProceedingsPending,
                                               prosecution_case_identifier_attributes: prosecution_case_identifier_attributes,
                                               hearings_attributes: hearings_attributes,
                                               defendants_attributes: defendant_attributes)
    end

    def defendant_attributes
      [:id,
       :numberOfPreviousConvictionsCited,
       :prosecutionAuthorityReference,
       :witnessStatement,
       :witnessStatementWelsh,
       :mitigation,
       :mitigationWelsh,
       :croNumber,
       :pncId,
       :mergedProsecutionCaseReference,
       :masterDefendantId,
       :courtProceedingsInitiated,
       :defendantDetailsUpdated,
       :defendable_type,
       { defendable_attributes: defendable_attributes,
         offences_attributes: offences_attributes }]
    end

    def prosecution_case_identifier_attributes
      %i[id caseURN prosecutionAuthorityReference prosecutionAuthorityId prosecutionAuthorityCode]
    end

    def hearings_attributes
      [:id,
       :jurisdictionType,
       :reportingRestrictionReason,
       :court_centre_id,
       :hearingLanguage,
       :hasSharedResults,
       :isEffectiveTrial,
       :isBoxHearing,
       { hearing_type_attributes: %i[id description] },
       { hearing_days_attributes: %i[id sittingDay listedDurationMinutes] }]
    end

    def defendable_attributes
      [:id,
       :bailConditions,
       :bailReasons,
       :perceivedBirthYear,
       :driverNumber,
       :driverLicenceCode,
       :driverLicenseIssue,
       :vehicleOperatorLicenceNumber,
       :arrestSummonsNumber,
       :employerPayrollReference,
       { person_attributes: person_attributes }]
    end

    def person_attributes
      %i[id
         title
         firstName
         middleName
         lastName
         dateOfBirth
         nationalityId
         nationalityCode
         nationalityDescription
         additionalNationalityId
         additionalNationalityCode
         additionalNationalityDescription
         disabilityStatus
         gender
         interpreterLanguageNeeds
         documentationLanguageNeeds
         nationalInsuranceNumber
         occupation
         occupationCode
         specificRequirements]
    end

    def offences_attributes
      %i[id offenceDefinitionId
         offenceCode
         offenceTitle
         offenceTitleWelsh
         offenceLegislation
         offenceLegislationWelsh
         modeOfTrial
         wording
         wordingWelsh
         startDate
         endDate
         arrestDate
         chargeDate
         dateOfInformation
         orderIndex
         count
         convictionDate
         aquittalDate
         isDisposed
         isDiscontinued
         isIntroduceAfterInitialProceedings
         splitProsecutorCaseReference
         mergedProsecutionCaseReference
         dvlaCode
         laidDate
         proceedingsConcluded
         pendingCBPW
         civilOffence]
    end
  end
  # rubocop:enable Metrics/ClassLength
end
