module Admin
  class JudicialResultsController < Admin::ApplicationController
    def create
      offence = Offence.find(params[:offence_id])
      hearing = Hearing.find(params[:id])
      FactoryBot.create(:judicial_result_with_relationships, hearing: hearing, offence: offence)

      redirect_to admin_hearing_url(hearing), notice: "Judicial result was successfully created."
    end

    def show
      @hearing = Hearing.find(params[:id])
      @offence = Offence.find(params[:offence_id])
      @judicial_result = JudicialResult.find(params[:judicial_result_id])
    end

    def edit
      @hearing = Hearing.find(params[:id])
      @offence = Offence.find(params[:offence_id])
      @judicial_result = JudicialResult.find(params[:judicial_result_id])
    end

    def update
      @hearing = Hearing.find(params[:id])
      @offence = Offence.find(params[:offence_id])
      @judicial_result = JudicialResult.find(params[:judicial_result_id])

      if @judicial_result.update(judicial_result_params)
        render :show, notice: "Judicial result was successfully updated."
      else
        render :edit
      end
    end

    def delete
      @hearing = Hearing.find(params[:id])
      JudicialResult.find(params[:judicial_result_id]).destroy!
      redirect_to admin_hearing_url(@hearing), notice: "Judicial result was successfully deleted."
    end

  private

    def judicial_result_params
      params.require(:judicial_result).permit(judicial_result_attributes)
    end

    def judicial_result_attributes
      [
        :id,
        :judicialResultId,
        :judicialResultTypeId,
        :orderedHearingId,
        :label,
        :welshLabel,
        :isAdjournmentResult,
        :isFinancialResult,
        :isConvictedResult,
        :isAvailableForCourtExtract,
        :isDeleted,
        :amendmentReasonId,
        :amendmentReason,
        :amendmentDate,
        :qualifier,
        :resultText,
        :cjsCode,
        :rank,
        :orderedDate,
        :postHearingCustodyStatus,
        :lastSharedDateTime,
        :terminatesOffenceProceedings,
        :approvedDate,
        :category,
        next_hearing_attributes: next_hearing_attributes,
      ]
    end

    def next_hearing_attributes
      [
        :id,
        :listedStartDateTime,
        :jurisdictionType,
        :estimatedMinutes,
        :hearingLanguage,
        :court_centre_id,
        hearing_type_attributes: %i[id description],
      ]
    end
  end
end
