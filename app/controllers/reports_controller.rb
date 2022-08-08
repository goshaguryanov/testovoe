class ReportsController < ApplicationController
  set_schemas create: Reports::CreateParams

  def create
    result = Report.call(safe_params.to_h)
    if result.success?
      render json: OperationBlueprint.render(result.value!)
    else
      render json: result.failure, status: 422
    end
  end
end
