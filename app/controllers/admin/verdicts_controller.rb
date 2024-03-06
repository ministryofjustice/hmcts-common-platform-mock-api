module Admin
  class VerdictsController < ApplicationController
    def create
      hearing = Hearing.find(params[:id])
      @offence = Offence.find(params[:offence_id])

      if @offence.verdicts.count.positive?
        redirect_to edit_admin_hearing_url(hearing), notice: "This offence already has a verdict."
      else
        @verdict_type = FactoryBot.build(:realistic_verdict_type)
        @offence.verdicts.create!(verdictDate: Time.zone.now, verdict_type: @verdict_type, hearing:)

        redirect_to edit_admin_hearing_url(hearing), notice: "Verdict was successfully added."
      end
    end
  end
end
