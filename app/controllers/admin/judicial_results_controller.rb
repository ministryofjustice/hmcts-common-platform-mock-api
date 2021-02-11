module Admin
  class JudicialResultsController < Admin::ApplicationController
    def create
      offence = Offence.find(params[:offence_id])
      hearing = Hearing.find(params[:id])
      FactoryBot.create(:judicial_result, hearing: hearing, offence: offence)

      redirect_to edit_admin_hearing_url(hearing)
    end
  end
end
