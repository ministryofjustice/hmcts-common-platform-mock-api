module Admin
  class CourtApplicationsController < Admin::ApplicationController
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
      hearing = Hearing.find(params[:hearing_id])
      court_application = FactoryBot.create(:court_application)
      hearing.court_applications << court_application
      prosecution_case = hearing.prosecution_cases.first

      CourtApplicationProsecutionCase.find_or_create_by!(
        court_application:,
        prosecution_case:,
      )

      CourtApplicationHearing.find_or_create_by!(
        court_application:,
        hearing:,
      )

      redirect_to admin_hearing_url(hearing), notice: "Court application was successfully created."
    end

    def show
      @court_application = CourtApplication.find(params[:id])
    end

    def edit
      @court_application = CourtApplication.find(params[:id])
      prosecution_case = ProsecutionCase.find(@court_application.prosecution_case)
      @defendants = prosecution_case.defendants
      @hearings = prosecution_case.hearings
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
      params.require(:court_application).permit(:id,
                                                :applicationReceivedDate,
                                                :applicationStatus,
                                                :outOfTimeReasons,
                                                :court_application_party_id,
                                                :applicationDecisionSoughtByDate,
                                                :applicationReference,
                                                :court_application_outcome_id,
                                                :applicationParticulars,
                                                :parentApplicationId,
                                                :court_application_payment_id,
                                                :breachedOrder,
                                                :hearing_id,
                                                :defendant_id,
                                                :court_application_type_id)
    end
  end
end
