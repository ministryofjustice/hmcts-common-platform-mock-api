module Admin
  class DefendantsCourtApplicationsController < Admin::ApplicationController
    def create
      defendant = Defendant.find(params[:defendant_id])

      court_application = FactoryBot.create(:defendant_court_application, defendant:)

      CourtApplicationProsecutionCase.find_or_create_by!(
        court_application:,
        prosecution_case: defendant.prosecution_case,
      )

      redirect_to admin_defendant_url(defendant), notice: "Court application was successfully created."
    end

    def destroy
      court_application = CourtApplication.find(params[:id])
      court_application.destroy!

      redirect_to admin_defendant_url(court_application.defendant_id), notice: "Court application was successfully deleted."
    end
  end
end
