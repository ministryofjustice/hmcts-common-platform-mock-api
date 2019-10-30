# frozen_string_literal: true

class ProsecutionCasesController < ApplicationController
  def index
    @prosecution_cases = ProsecutionCase.all
    render json: { prosecutionCases: Jbuilder.new.array!(prosecution_cases_builder) }
  end

  private

  def prosecution_cases_builder
    @prosecution_cases.ids.map do |prosecution_case_id|
      ProsecutionCaseSummary.new(prosecution_case_id: prosecution_case_id).to_builder.attributes!
    end
  end
end
