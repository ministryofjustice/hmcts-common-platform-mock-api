module Admin
  class HearingDaysController < Admin::ApplicationController
    def create
      hearing = Hearing.find(params[:hearing_id])
      FactoryBot.create(:realistic_hearing_day, hearing: hearing)

      redirect_to admin_hearing_url(hearing), notice: "Hearing day was successfully created."
    end

    def show
      @hearing_day = HearingDay.find(params[:id])
    end

    def edit
      @hearing_day = HearingDay.find(params[:id])
    end

    def update
      @hearing_day = HearingDay.find(params[:id])

      if @hearing_day.update(hearing_day_params)
        render :show, notice: "Hearing day was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      hearing_day = HearingDay.find(params[:id])
      hearing = hearing_day.hearing

      hearing_day.destroy!

      redirect_to admin_hearing_url(hearing), notice: "Hearing day was successfully deleted."
    end

  private

    def hearing_day_params
      params.require(:hearing_day).permit(hearing_day_attributes)
    end

    def hearing_day_attributes
      %i[
        id
        sittingDay
        listingSequence
        listedDurationMinutes
        isCancelled
        court_centre_id
        courtRoomId
      ]
    end
  end
end
