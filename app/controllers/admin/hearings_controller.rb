# frozen_string_literal: true

module Admin
  class HearingsController < Admin::ApplicationController
    before_action :set_prosecution_case, only: %i[new create]
    before_action :set_hearing, only: %i[show edit update destroy add_plea add_allocation_decision add_judicial_result]

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

    def add_plea
      @offence = Offence.find(params[:offence_id])
      @offence.pleas.create!(pleaDate: Time.zone.now, pleaValue: Plea::VALUES.first, hearing: @hearing)
      redirect_to edit_admin_hearing_url(@hearing), notice: "Plea was successfully added."
    end

    def add_allocation_decision
      @offence = Offence.find(params[:offence_id])
      @offence.allocation_decisions.create!(allocationDecisionDate: Time.zone.now, motReasonId: SecureRandom.uuid, motReasonCode: 0, motReasonDescription: Faker::Offence.mode_of_trial_reason, hearing: @hearing)
      redirect_to edit_admin_hearing_url(@hearing), notice: "Allocation decision was successfully added."
    end

    def add_judicial_result
      @offence = Offence.find(params[:offence_id])
      @offence.judicial_results.create!(
        judicialResultId: SecureRandom.uuid,
        judicialResultTypeId: SecureRandom.uuid,
        orderedHearingId: SecureRandom.uuid,
        label: Faker::Lorem.word,
        welshLabel: Faker::Lorem.word,
        isAdjournmentResult: Faker::Boolean.boolean,
        isFinancialResult: Faker::Boolean.boolean,
        isConvictedResult: Faker::Boolean.boolean,
        isAvailableForCourtExtract: Faker::Boolean.boolean,
        isDeleted: Faker::Boolean.boolean,
        amendmentReasonId: SecureRandom.uuid,
        amendmentReason: Faker::Lorem.word,
        amendmentDate: Faker::Date.backward,
        qualifier: Faker::Lorem.word,
        resultText: Faker::Lorem.word,
        cjsCode: Faker::Number.number(digits: 4),
        postHearingCustodyStatus: %w[A B C L P R S U].sample,
        rank: Faker::Number.number(digits: 1),
        orderedDate: Faker::Date.backward,
        lastSharedDateTime: Faker::Date.backward,
        terminatesOffenceProceedings: Faker::Boolean.boolean,
        approvedDate: Faker::Date.backward,
        category: %w[FINAL INTERMEDIARY ANCILLARY].sample,
        hearing: @hearing,
      )
      redirect_to edit_admin_hearing_url(@hearing), notice: "Judicial result was successfully added."
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
                                      :jurisdictionType,
                                      :reportingRestrictionReason,
                                      :court_centre_id,
                                      :hearingLanguage,
                                      :hasSharedResults,
                                      :isEffectiveTrial,
                                      :isBoxHearing,
                                      { prosecution_cases_attributes: prosecution_cases_attributes },
                                      { hearing_type_attributes: %i[id description] },
                                      { hearing_days_attributes: %i[id sittingDay listedDurationMinutes] })
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
