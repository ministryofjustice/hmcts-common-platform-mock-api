# frozen_string_literal: true

class ProsecutionCasesDataService < ApplicationService
  def initialize(params)
    @is_guilty = params[:is_guilty]
    @result_code = params[:result_code]
    @prosecution_case = FactoryBot.create(:generic_prosecution_case)
  end

  def call
    set_verdict
    set_result_code
    @prosecution_case
  end

private

  def hearing
    @prosecution_case.hearings.first
  end

  def defendant
    @prosecution_case.defendants.first
  end

  def offence
    defendant.offences.first
  end

  def judicial_result
    offence.judicial_results.first
  end

  def set_result_code
    judicial_result.cjsCode = @result_code
    judicial_result.save!
  end

  def set_verdict
    verdict_type = if @is_guilty
                     FactoryBot.build(:realistic_verdict_type)
                   else
                     FactoryBot.build(:realistic_verdict_type, :not_guilty)
                   end

    offence.verdicts.create!(verdictDate: Time.zone.now, verdict_type: verdict_type, hearing: hearing)
  end
end
