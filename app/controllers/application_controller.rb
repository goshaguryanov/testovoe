class ApplicationController < ActionController::API
  before_action :render_params_errors

  class << self
    def set_schemas(schemas = {})
      @schemas ||= {}
      schemas.each_pair do |verb, schema|
        @schemas[verb] = schema
      end
    end
  end

  private

  def render_params_errors
    render json: {errors: safe_params.errors.to_h}, status: :unprocessable_entity if safe_params && safe_params.failure?
  end
end
