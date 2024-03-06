module Admin
  class PleasController < ApplicationController
    def create
      hearing = Hearing.find(params[:id])
      @offence = Offence.find(params[:offence_id])
      @offence.pleas.create!(pleaDate: Time.zone.now, pleaValue: Plea::VALUES.first, hearing:)

      redirect_to edit_admin_hearing_url(hearing), notice: "Plea was successfully added."
    end
  end
end
