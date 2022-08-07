class Operation < ApplicationRecord
  belongs_to :user
  KINDS = { income: 0, expense: 1 }.freeze
  enum kind: KINDS
end
