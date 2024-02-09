# frozen_string_literal: true
module Test
  class ProsecutionCasesController < ApplicationController
    def create
      enforce_contract!
      prosecution_case = ProsecutionCasesDataService.call(valid_parameters)
      render json: ProsecutionCaseSummary.new(prosecution_case_id: prosecution_case.id).to_builder.attributes!
    end

    def result
      hearing = Hearing.find_by(hearing_id: params[:hearing_id])
      HearingResulter.call(hearing_id: hearing.id, publish_to: params[:publish_to])
      render json: { message: "Hearing {params[:hearing_id] resulted and posted to CDA {params[:publish_to]}" }, status: :ok

    end

    def publish
      ProsecutionCaseConcluder.call(prosecution_case_id: params[:id], publish_to: params[:publish_to])
      render json: { message: "Case {params[:id] concluded and posted to CDA {params[:publish_to]}" }, status: :ok
    end

    def valid_parameters
      params.require(:prosecution_case).permit(:is_guilty, :result_code)
    end

    def transformed_params
      valid_parameters.to_hash.deep_symbolize_keys.compact
    end

    def enforce_contract!
      unless contract.success?
        message = "Prosecution case test data contract failed with: #{contract.errors.to_hash}"
        raise Errors::ContractError, message
      end
    end

    def contract
      ProsecutionCaseTestDataContract.new.call(**transformed_params)
    end
  end
end
