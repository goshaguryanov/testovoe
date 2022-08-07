class Income < Mutations::Command
  required do
    string :title
    integer :user_id
    float :sum
    date :date
  end

  def execute
    inputs.merge!(kind: :income)
    operation = Operation.create(inputs)
  end
end
