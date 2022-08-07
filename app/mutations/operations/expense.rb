class Expense < Mutations::Command
  required do
    string :title
    integer :user_id
    float :sum
    date :date
  end

  def execute
    inputs.merge!(kind: :expense)
    operation = Operation.create(inputs)
  end
end
