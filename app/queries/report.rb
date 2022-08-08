require 'dry/monads'

class Report
  extend Dry::Monads[:result]

  def initialize(klass: Operation)
    @klass = klass
  end

  def self.call(params)
    begin
      Success(new.call(params))
    rescue => exception
      Failure(exception.message)
    end
  end

  def call(params)
    klass.find_by_sql(query(params))
  end

  private

  def query(params)
  end

  attr_accessor :klass
end
