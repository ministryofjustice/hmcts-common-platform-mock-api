module Admin
  class CourtApplicationsController < Admin::ApplicationController
    before_action :set_env_list, only: :show
    before_action :set_application_and_case, only: :show
    before_action :add_breadcrumbs, only: :show

    def index
      scope = CourtApplication.order(created_at: :desc)
      scope = scope.where(id: params[:query]) if params[:query].present?
      @court_applications = scope.page(params[:page])
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

    def show; end

    def edit
      @court_application = CourtApplication.find(params[:id])
      # checks for existing court applications for prosecution_case as this is a new link table used only for appeals work.
      if @court_application.prosecution_case.present?
        @prosecution_case = @court_application.prosecution_case.first
        @defendants = @prosecution_case.defendants
        @hearings = @prosecution_case.hearings
      end
    end

    def update
      @court_application = CourtApplication.find(params[:id])

      if @court_application.update(court_application_params)
        redirect_to admin_court_application_path(@court_application), notice: "Court application was successfully updated."
      else
        redirect_to admin_court_application_path(@court_application), notice: "Court application was not updated. Please check the errors."
      end
    end

    def destroy
      court_application = CourtApplication.find(params[:id])

      court_application.destroy!

      redirect_to admin_hearing_url(court_application.hearing_id), notice: "Court application was successfully deleted."
    end

    def result
      notice = if HearingResulter.call(hearing_id: params[:hearing_id], publish_to: params[:publish_to])
                 "Hearing was successfully resulted"
               else
                 "Hearing could not be resulted"
               end
      redirect_to(admin_court_application_path(params[:id]), notice:)
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
                                                :court_application_type_id,
                                                :result_code)
    end

    def set_application_and_case
      @court_application = CourtApplication.find(params[:id])
      @court_application_hearings = @court_application.court_hearings

      if @court_application.prosecution_case.present?
        @prosecution_case = @court_application.prosecution_case.first
        @prosecution_case_hearings = @prosecution_case.hearings
      end
    end

    def add_breadcrumbs
      if @court_application.prosecution_case.present?
        breadcrumbs.add(@prosecution_case.prosecution_case_identifier.caseURN,
                        admin_prosecution_case_path(@prosecution_case))
      end

      if @court_application.defendant
        breadcrumbs.add(@court_application.defendant.name,
                        admin_defendant_path(@court_application.defendant))
      elsif @court_application.hearing
        breadcrumbs.add("Hearing #{@court_application.hearing.hearing_id.truncate(8)}",
                        admin_hearing_path(@court_application.hearing))
      end

      breadcrumbs.add("Court application: #{@court_application.id.truncate(8)}")
    end
  end
end
