module Admin
  class RespondentsController < ApplicationController
    def edit
      @respondent = CourtApplicationParty.find(params[:id])
    end

    def update
      respondent = CourtApplicationParty.find(params[:id])
      hearing = CourtApplication.find(respondent.court_application_id).hearing

      if respondent.update(respondent_params)
        redirect_to admin_hearing_url(hearing), notice: "Respondent was successfully updated."
      else
        render :edit
      end
    end

  private

    def respondent_params
      params.require(:court_application_party).permit(:synonym)
    end
  end
end
