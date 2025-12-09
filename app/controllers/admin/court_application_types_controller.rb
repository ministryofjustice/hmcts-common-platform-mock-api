module Admin
  class CourtApplicationTypesController < ApplicationController
    def edit
      court_application = CourtApplication.find(params[:court_application_id])
      @court_application_type = court_application.court_application_type
      @codes_and_titles = CourtApplicationType::COURT_APPLICATION_TYPES.map do |code, attrs|
        ["#{code} - #{attrs['category'].capitalize} – #{attrs['title']}", code] # [label, value]
      end
    end

    def update
      court_application = CourtApplication.find(params[:court_application_id])

      if court_application.court_application_type.update(court_application_type_params)
        redirect_to admin_court_application_url(court_application), notice: "Court application type was successfully updated."
      else
        render :edit
      end
    end

  private

    def court_application_type_params
      params.require(:court_application_type).permit(:code, :type, :legislation, :has_offences)
    end
  end
end
