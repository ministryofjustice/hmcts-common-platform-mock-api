# frozen_string_literal: true

module Admin
  class ProsecutionCasesController < Admin::ApplicationController
    before_action :set_prosecution_case, only: %i[show edit update destroy result]
    before_action :set_env_list
    before_action :add_breadcrumbs, only: :show

    def index
      @prosecution_cases = if params[:query].present?
                             ProsecutionCase.search(params[:query]).order(created_at: :desc).page(params[:page])
                           else
                             ProsecutionCase.order(created_at: :desc).page(params[:page])
                           end
    end

    def show; end

    def new
      @prosecution_case = FactoryBot.build(:realistic_prosecution_case)

      if params[:defendant_id]
        defendant = Defendant.find(params[:defendant_id])
        @prosecution_case.defendants.first.masterDefendantId = defendant.masterDefendantId
        @prosecution_case.defendants.first.defendable.person = defendant.defendable.person.dup
      end
    end

    def edit; end

    def create
      @prosecution_case = ProsecutionCase.new(prosecution_case_params)

      if @prosecution_case.save
        redirect_to [:admin, @prosecution_case], notice: "Prosecution case was successfully created."
      else
        render :new
      end
    end

    def update
      if @prosecution_case.update(prosecution_case_params)
        redirect_to [:admin, @prosecution_case], notice: "Prosecution case was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @prosecution_case.destroy!
      redirect_to admin_prosecution_cases_url, notice: "Prosecution case was successfully destroyed."
    end

    def result
      if HearingResulter.call(hearing_id: params[:hearing_id], publish_to: params[:publish_to])
        redirect_to [:admin, @prosecution_case], notice: "Hearing was successfully resulted."
      else
        render :edit
      end
    end

    def associate_court_application
      create_court_application_association
      redirect_to admin_court_application_path(params[:court_application_id]), flash: { notice: "Case associated" }
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
                                               :summons_code,
                                               :class_of_case,
                                               :is_cps_org_verify_error,
                                               prosecution_case_identifier_attributes:,
                                               hearings_attributes:,
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
       { defendable_attributes:,
         offences_attributes: }]
    end

    def prosecution_case_identifier_attributes
      %i[id caseURN prosecutionAuthorityReference prosecutionAuthorityId prosecutionAuthorityCode]
    end

    def hearings_attributes
      [:id,
       :hearing_id,
       :sitting_day,
       :jurisdictionType,
       :reportingRestrictionReason,
       :court_centre_id,
       :hearingLanguage,
       :hasSharedResults,
       :isEffectiveTrial,
       :isBoxHearing,
       { hearing_type_attributes: %i[id description] },
       { hearing_days_attributes: }]
    end

    def hearing_days_attributes
      %i[id
         sittingDay
         listedDurationMinutes
         court_centre_id
         courtRoomId
         listingSequence
         isCancelled]
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
       { person_attributes: }]
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
      %i[id
         offenceDefinitionId
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
         civilOffence
         _destroy]
    end

    def add_breadcrumbs
      breadcrumbs.add(@prosecution_case.prosecution_case_identifier.caseURN)
    end

    def create_court_application_association
      p_case = ProsecutionCase.find(params[:id])
      court_application = CourtApplication.find(params[:court_application_id])
      court_application.prosecution_cases << p_case
    end
  end
end
