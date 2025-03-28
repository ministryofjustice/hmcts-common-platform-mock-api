class ApplicationReferenceRecorder < LaaReferenceRecorder
  def initialize(params)
    @params = params
    @schema = JSON.parse(File.open(Rails.root.join("lib/schemas/api/progression.recordApplicationReference.json")).read)
    register_dependant_schemas!
  end

private

  def permitted_params
    params.permit(:applicationId, :subjectId, :offenceId, :statusCode, :applicationReference, :statusDate)
  end
end
