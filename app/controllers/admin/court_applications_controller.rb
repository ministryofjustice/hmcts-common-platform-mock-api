module Admin
  class CourtApplicationsController < Admin::ApplicationController
    def create
      hearing = Hearing.find(params[:hearing_id])
      hearing.court_applications << FactoryBot.create(:court_application)

      redirect_to admin_hearing_url(hearing), notice: "Court application was successfully created."
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

      redirect_to admin_hearing_url(court_application.hearing_id), notice: "Court application was successfully deleted."
    end

  private

    def court_application_params
      params.require(:court_application).permit(:id, :applicationReceivedDate)
    end
  end
end
