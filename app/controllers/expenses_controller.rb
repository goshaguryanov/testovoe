class ExpensesController < ApplicationController
  set_schemas create: Operations::CreateParams

  def create
    operation = Expense.run(safe_params.to_h)
    if operation.success?
      render json: { message: operation.result }
    else
      render json: operation.errors.symbolic, status: 422
    end
  end
end
