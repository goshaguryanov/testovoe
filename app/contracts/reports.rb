class Reports
  CreateParams = Dry::Schema.Params {
    required(:user_id).value(:integer)
    required(:from_date).value(:date)
    required(:to_date).value(:date)
  }
end
