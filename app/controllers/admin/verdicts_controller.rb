module Admin
  class VerdictsController < ApplicationController
    def create
      hearing = Hearing.find(params[:id])
      @offence = Offence.find(params[:offence_id])
      @verdict_type = FactoryBot.build(:realistic_verdict_type)
      @offence.verdicts.create!(verdictDate: Time.zone.now, verdict_type: @verdict_type, hearing: hearing)

      redirect_to edit_admin_hearing_url(hearing), notice: "Verdict was successfully added."
    end
  end
end
