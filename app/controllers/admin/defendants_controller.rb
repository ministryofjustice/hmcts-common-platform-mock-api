# frozen_string_literal: true

module Admin
  class DefendantsController < Admin::ApplicationController
    before_action :set_defendant, only: %i[show edit update destroy]

    def show; end

    def edit; end

    def new
      @prosecution_case = ProsecutionCase.find(params[:prosecution_case_id])
      @defendant = FactoryBot.build(:realistic_defendant)
    end

    def create
      @prosecution_case = ProsecutionCase.find(params[:prosecution_case_id])
      @defendant = @prosecution_case.defendants.build(defendant_params)

      if @defendant.save
        redirect_to [:admin, @defendant], notice: "Defendant was successfully created."
      else
        render :new
      end
    end

    def update
      if @defendant.update(defendant_params)
        redirect_to [:admin, @defendant], notice: "Defendant was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @defendant.destroy!
      redirect_to admin_prosecution_case_url(@defendant.prosecution_case), notice: "Defendant was successfully destroyed."
    end

  private

    def set_defendant
      @defendant = Defendant.find(params[:id])
    end

    def defendant_params
      params.require(:defendant).permit(
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
          offences_attributes: offences_attributes },
      )
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
      [:id,
       :offenceDefinitionId,
       :offenceCode,
       :offenceTitle,
       :offenceTitleWelsh,
       :offenceLegislation,
       :offenceLegislationWelsh,
       :modeOfTrial,
       :wording,
       :wordingWelsh,
       :startDate,
       :endDate,
       :arrestDate,
       :chargeDate,
       :dateOfInformation,
       :orderIndex,
       :count,
       :convictionDate,
       :aquittalDate,
       :isDisposed,
       :isDiscontinued,
       :isIntroduceAfterInitialProceedings,
       :splitProsecutorCaseReference,
       :mergedProsecutionCaseReference,
       :dvlaCode,
       :laidDate,
       :proceedingsConcluded,
       :pendingCBPW,
       :civilOffence,
       :_destroy,
       { judicial_results_attributes: judicial_results_attributes }]
    end

    def judicial_results_attributes
      %i[
        id
        judicialResultId
        judicialResultTypeId
        orderedHearingId
        label
        welshLabel
        isAdjournmentResult
        isFinancialResult
        isConvictedResult
        isAvailableForCourtExtract
        isDeleted
        amendmentReasonId
        amendmentReason
        amendmentDate
        qualifier
        resultText
        cjsCode
        rank
        orderedDate
        postHearingCustodyStatus
        lastSharedDateTime
        terminatesOffenceProceedings
        approvedDate
        category
      ]
    end
  end
end
