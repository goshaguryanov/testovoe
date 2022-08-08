class Operations
  CreateParams = Dry::Schema.Params {
    required(:user_id).value(:integer)
    required(:title).value(:string)
    required(:date).value(:date)
    required(:sum).value(:float)
  }
end
