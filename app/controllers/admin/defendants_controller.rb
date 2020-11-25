module Admin
  class DefendantsController < Admin::ApplicationController
    before_action :set_defendant, only: %i[show edit update]

    def show
    end

    def edit
    end

    def update
      if @defendant.update(defendant_params)
        redirect_to [:admin, @defendant], notice: 'Defendant was successfully updated.'
      else
        render :edit
      end
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
       { defendable_attributes: defendable_attributes})
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
  end
end
