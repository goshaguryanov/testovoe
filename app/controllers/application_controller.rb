class ApplicationController < ActionController::API
  class << self
    def set_schemas(schemas = {})
      @schemas ||= {}
      schemas.each_pair do |verb, schema|
        @schemas[verb] = schema
      end
    end
  end
end
