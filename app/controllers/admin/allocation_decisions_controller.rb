module Admin
  class AllocationDecisionsController < ApplicationController
    def create
      @hearing = Hearing.find(params[:id])
      @offence = Offence.find(params[:offence_id])
      @offence.allocation_decisions.create!(allocationDecisionDate: Time.zone.now, motReasonId: SecureRandom.uuid, motReasonCode: 0, motReasonDescription: Faker::Offence.mode_of_trial_reason, hearing: @hearing)

      redirect_to edit_admin_hearing_url(@hearing), notice: "Allocation decision was successfully added."
    end
  end
end
