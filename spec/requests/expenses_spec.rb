require 'rails_helper'

RSpec.describe "Expenses", type: :request do
  describe "POST /expense" do
    context "without valid params" do
      it "returns http success" do
        post "/expense"
        expect(response).not_to have_http_status(:success)
      end
    end

   context "with valid params" do
      let(:operation) { double(:operation) }
      let(:user) { create(:user) }
      let(:params) do
        {
          user_id: user.id,
          title: 'title',
          date: DateTime.now,
          sum: 10.0
        }
      end

      before do
        allow(Expense).to receive(:run).and_return(operation)
        allow(operation).to receive(:success?).and_return(true)
        allow(operation).to receive(:result)
      end

      it "returns http success" do
        post "/expense", params: params
        expect(response).to have_http_status(:success)
      end

      it "call mutation" do
        expect(Expense).to receive(:run)
        post "/expense", params: params
      end
    end
  end
end
