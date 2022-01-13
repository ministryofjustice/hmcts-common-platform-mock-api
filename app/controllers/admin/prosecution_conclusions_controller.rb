# frozen_string_literal: true

module Admin
  class ProsecutionConclusionsController < Admin::ApplicationController
    def create
      @prosecution_case = ProsecutionCase.find(params[:prosecution_case_id])

      ProsecutionCaseConcluder.call(prosecution_case_id: params[:prosecution_case_id], publish_to: params[:publish_to])

      redirect_to [:admin, @prosecution_case], notice: "Prosecution Case was successfully concluded."
    end
  end
end
