require 'dry/monads'

class Report
  extend Dry::Monads[:result]

  COLUMNS = [:title, :date].freeze

  def initialize(klass: Operation, params: {})
    @klass     = klass
    @from_date = params[:from_date]
    @to_date   = params[:to_date]
    @user_id   = params[:user_id]
  end

  def self.call(params)
    begin
      Success(new(params: params).call)
    rescue => exception
      Failure(exception.message)
    end
  end

  def call
    klass.find_by_sql(query)
  end

  private

  def query
    table.project(
      *columns,
      table[:sum],
      reminder
    ).from(sub_query.to_sql).where(
      table[:date].gt(from_date)
    ).where(
      table[:date].lteq(to_date)
    ).order(table[:date])
  end

  attr_accessor :klass, :from_date, :to_date, :user_id

  def reminder
    Arel::Nodes::NamedFunction.new('coalesce',
      [
        table[:sum].sum.over(window),
        sql_literal('0')
      ]
    ).as('reminder')
  end

  def window
    window = Arel::Nodes::Window.new
    window.frame(
      Arel::Nodes::Between.new(
        window.rows,
        Arel::Nodes::And.new([
          Arel::Nodes::Preceding.new,
          Arel::Nodes::CurrentRow.new
        ])
      )
    )
    window.order(table[:date])
  end

  def sub_query
    table.create_table_alias(union, table.name)
  end

  def union
    sub_union(:income).union sub_union(:expense)
  end

  def sub_union(kind)
    table.project(
      *columns,
      with_sign(kind).as('sum')
    ).where(
      table[:kind].eq(klass::KINDS[kind])
    ).where(
      table[:user_id].eq(user_id)
    )
  end

  def with_sign(kind)
    case kind
    when :income
      table[:sum]
    when :expense
      minus table[:sum]
    end
  end

  def columns
    COLUMNS.map {|column| table[column] }
  end

  def minus(column)
    Arel::Nodes::Subtraction.new(
      sql_literal('0'),
      column
    )
  end

  def sql_literal(str)
    Arel::Nodes::SqlLiteral.new(str)
  end

  def table
    klass.arel_table
  end
end
