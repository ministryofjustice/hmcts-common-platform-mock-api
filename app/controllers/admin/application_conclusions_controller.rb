# frozen_string_literal: true

module Admin
  class ApplicationConclusionsController < Admin::ApplicationController
    def create
      CourtApplicationConcluder.call(court_application_id: params[:id], publish_to: params[:publish_to])

      redirect_to admin_court_application_path(params[:id]), notice: "Prosecution Case was successfully concluded."
    end
  end
end
