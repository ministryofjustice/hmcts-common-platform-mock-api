module Admin
  class CourtApplicationHearingController < Admin::ApplicationController
    def create
      CourtApplicationHearing.find_or_create_by!(court_application_params)

      redirect_to admin_court_application_path(court_application_params[:court_application_id]), notice: "Prosecution hearing was successfully add to Court application."
    end

    def destroy
      court_application_hearing = CourtApplicationHearing.find_by(hearing_id: court_application_params[:hearing_id], court_application_id: court_application_params[:court_application_id])

      court_application_hearing.destroy!

      redirect_to admin_court_application_path(court_application_params[:court_application_id]), notice: "Court application hearing was successfully deleted."
    end

  private

    def court_application_params
      params.permit(:hearing_id, :court_application_id)
    end
  end
end
