# frozen_string_literal: true
module Test
  class ProsecutionCasesController < ApplicationController
    def create
      prosecution_case = ProsecutionCasesDataService.call(valid_parameters)
      render json: ProsecutionCaseSummary.new(prosecution_case_id: prosecution_case.id).to_builder.attributes!
    end

    def result
      hearing_id = Hearing.find_by(hearing_id: params[:hearing_id]).id
      HearingResulter.call(hearing_id: hearing_id, publish_to: params[:publish_to])
    end

    def publish
      ProsecutionCaseConcluder.call(prosecution_case_id: params[:id], publish_to: params[:publish_to])
    end

    def valid_parameters
      params.require(:prosecution_case).permit(:is_guilty, :result_code)
    end

  end
end
