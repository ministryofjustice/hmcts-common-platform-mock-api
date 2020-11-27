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
        redirect_to [:admin, @prosecution_case], notice: 'Hearing was successfully created.'
      else
        render :new
      end
    end

    def update
      if @hearing.update(hearing_params)
        redirect_to [:admin, @prosecution_case], notice: 'Hearing was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @hearing.destroy
      redirect_to [:admin, @prosecution_case], notice: 'Hearing was successfully destroyed.'
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
                                      { hearing_type_attributes: %i[id description] },
                                      { hearing_days_attributes: %i[id sittingDay listedDurationMinutes] })
    end
  end
end
