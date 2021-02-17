module Admin
  class OffencesController < ApplicationController
    def create
      @defendant = Defendant.find(params[:defendant_id])
      @offence = @defendant.offences.build(offence_params)

      if @defendant.save
        redirect_to admin_defendant_path(@defendant), notice: "Offence was successfully created."
      else
        render :new
      end
    end

    def new
      @defendant = Defendant.find(params[:defendant_id])
      @offence = FactoryBot.build(:offence, defendant: @defendant)
    end

  private

    def offence_params
      params.require(:offence).permit(
        :id,
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
      )
    end
  end
end
