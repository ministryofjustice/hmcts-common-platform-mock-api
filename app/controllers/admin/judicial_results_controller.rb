module Admin
  class JudicialResultsController < Admin::ApplicationController
    def create
      court_application = CourtApplication.find(params[:court_application_id]) if params[:court_application_id]
      offence = Offence.find_by(id: params[:offence_id])
      hearing = Hearing.find_by(id: params[:id]) || court_application.hearing

      FactoryBot.create(:judicial_result_with_relationships, hearing: hearing, offence: offence, court_application: court_application)

      redirect_to admin_hearing_url(hearing), notice: "Judicial result was successfully created."
    end

    def show
      @judicial_result = JudicialResult.find(params[:id])
    end

    def edit
      @judicial_result = JudicialResult.find(params[:id])
    end

    def update
      @judicial_result = JudicialResult.find(params[:id])

      if @judicial_result.update(judicial_result_params)
        render :show, notice: "Judicial result was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      judicial_result = JudicialResult.find(params[:id])
      judicial_result.destroy!

      redirect_to admin_hearing_url(judicial_result.hearing_id), notice: "Judicial result was successfully deleted."
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
        { next_hearing_attributes: next_hearing_attributes },
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
        { hearing_type_attributes: %i[id description] },
      ]
    end
  end
end
