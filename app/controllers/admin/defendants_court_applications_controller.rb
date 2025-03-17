module Admin
  class DefendantsCourtApplicationsController < Admin::ApplicationController
    def index
      @court_applications = if params[:query].present?
                              CourtApplication.search(params[:query]).order(created_at: :desc).page(params[:page])
                            else
                              CourtApplication.order(created_at: :desc).page(params[:page])
                            end
    end

    def new
      @court_application = FactoryBot.build(:court_application)
    end

    def create
      defendant = Defendant.find(params[:defendant_id])

      court_application = FactoryBot.create(:defendant_court_application, defendant:)

      CourtApplicationProsecutionCase.find_or_create_by!(
        court_application:,
        prosecution_case: defendant.prosecution_case,
      )

      redirect_to admin_defendant_url(defendant), notice: "Court application was successfully created."
    end

    def show
      @court_application = CourtApplication.find(params[:id])
    end

    def edit
      @court_application = CourtApplication.find(params[:id])
    end

    def update
      @court_application = CourtApplication.find(params[:id])

      if @court_application.update(court_application_params)
        redirect_to admin_court_application_path(@court_application), notice: "Court application was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      court_application = CourtApplication.find(params[:id])
      court_application.destroy!
      redirect_to admin_defendant_url(court_application.defendant_id), notice: "Court application was successfully deleted."
    end

  private

    def court_application_params
      params.require(:court_application).permit(:id, :applicationReceivedDate)
    end
  end
end
