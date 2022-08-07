require 'rails_helper'

describe Expense do
  let(:user) { create(:user) }
  let(:input) {
    attributes_for(:operation, user_id: user.id)
  }

  it 'should change operation count by 1' do
    expect do
      described_class.run(input)
    end.to change { Operation.count }.by(1)
  end

  it 'result should be an operation' do
    value = described_class.run(input)
    value.result.should be_a Operation
  end

  it 'result.kind should be income' do
    value = described_class.run(input)
    result = value.result.expense?
    result.should be_truthy
  end
end
