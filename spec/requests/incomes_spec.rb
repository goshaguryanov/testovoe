require 'rails_helper'

RSpec.describe "Incomes", type: :request do
  describe "GET /create" do
    context "without valid params" do
      it "returns http error" do
        post "/income"
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
        allow(Income).to receive(:run).and_return(operation)
        allow(operation).to receive(:success?).and_return(true)
        allow(operation).to receive(:result)
      end

      it "returns http success" do
        post "/income", params: params
        expect(response).to have_http_status(:success)
      end

      it "call mutation" do
        expect(Income).to receive(:run)
        post "/income", params: params
      end
    end
  end
end
