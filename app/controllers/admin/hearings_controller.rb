# frozen_string_literal: true

module Admin
  class HearingsController < Admin::ApplicationController
    before_action :set_prosecution_case, only: %i[new create]
    before_action :set_hearing, only: %i[show edit update destroy]

    def show; end

    def new
      @hearing = FactoryBot.build(:realistic_hearing)
    end

    def edit; end

    def create
      @hearing = Hearing.new(hearing_params.merge(prosecution_case_ids: @prosecution_case.id))

      if @hearing.save
        redirect_to [:admin, @prosecution_case], notice: "Hearing was successfully created."
      else
        render :new
      end
    end

    def update
      if @hearing.update(hearing_params)
        redirect_to [:admin, @prosecution_case], notice: "Hearing was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @hearing.destroy!
      redirect_to [:admin, @prosecution_case], notice: "Hearing was successfully destroyed."
    end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_hearing
      @hearing = Hearing.find(params[:id])
      @prosecution_case = @hearing.prosecution_cases.first
    end

    def set_prosecution_case
      @prosecution_case = ProsecutionCase.find(params[:prosecution_case_id])
    end

    # Only allow a list of trusted parameters through.
    def hearing_params
      params.require(:hearing).permit(:hearing,
                                      :hearing_id,
                                      :sitting_day,
                                      :jurisdictionType,
                                      :reportingRestrictionReason,
                                      :court_centre_id,
                                      :hearingLanguage,
                                      :hasSharedResults,
                                      :isEffectiveTrial,
                                      :isBoxHearing,
                                      :cracked_ineffective_trial_id,
                                      { prosecution_cases_attributes: prosecution_cases_attributes },
                                      { hearing_type_attributes: %i[id description] },
                                      { hearing_days_attributes: hearing_days_attributes })
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

    def prosecution_cases_attributes
      [:id, { defendants_attributes: defendant_attributes }]
    end

    def defendant_attributes
      [:id, { offences_attributes: offences_attributes }]
    end

    def offences_attributes
      [
        :id,
        { pleas_attributes: %i[id hearing_id pleaValue pleaDate _destroy] },
        { verdicts_attributes:
          [
            :id,
            :hearing_id,
            :verdictDate,
            :_destroy,
            { verdict_type_attributes: %i[id sequence description category categoryType cjsVerdictCode verdictCode _destroy] },
          ] },
        { allocation_decisions_attributes:
          %i[
            id
            hearing_id
            allocationDecisionDate
            motReasonId
            motReasonCode
            motReasonDescription
            _destroy
          ] },
        { judicial_results_attributes:
          %i[
            id
            hearing_id
            judicialResultId
            orderedHearingId
            judicialResultTypeId
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
            cjsCode:
            postHearingCustodyStatus
            rank:
            orderedDate
            lastSharedDateTime
            terminatesOffenceProceedings
            approvedDate
            category
            _destroy
          ] },
      ]
    end
  end
end
