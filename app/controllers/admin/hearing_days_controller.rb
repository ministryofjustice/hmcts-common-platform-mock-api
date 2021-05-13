  module Admin
  class HearingDaysController < Admin::ApplicationController
    def create
      hearing = Hearing.find(params[:id])
      FactoryBot.create(:realistic_hearing_day, hearing: hearing)

      redirect_to admin_hearing_url(hearing), notice: "Hearing day was successfully created."
    end

    def show
      @hearing = Hearing.find(params[:id])
      @hearing_day = HearingDay.find(params[:hearing_day_id])
    end

    # def edit
    #   @hearing = Hearing.find(params[:id])
    #   @hearing_day = HearingDay.find(params[:hearing_day_id])
    # end

    # def update
    #   @hearing = Hearing.find(params[:id])
    #   @hearing_day = HearingDay.find(params[:hearing_day_id])

    #   if @hearing_day.update(hearing_day_params)
    #     render :show, notice: "Judicial result was successfully updated."
    #   else
    #     render :edit
    #   end
    # end

    # def delete
    #   @hearing = Hearing.find(params[:id])
    #   HearingDay.find(params[:hearing_day_id]).destroy!
    #   redirect_to admin_hearing_url(@hearing), notice: "Judicial result was successfully deleted."
    # end
  end
end
