require 'rails_helper'

RSpec.describe "Reports", type: :request do
  context "without valid params" do
    describe "POST /report" do
      it "returns http success" do
        post "/report"
        expect(response).not_to have_http_status(:success)
      end
    end
  end

  context "with valid params" do
    let(:monad) { double(:monad) }
    let(:user) { create(:user) }
    let(:params) do
      {
        user_id: user.id,
        from_date: 1.days.ago,
        to_date: DateTime.now
      }
    end

    before do
      allow(OperationBlueprint).to receive(:render)
      allow(Report).to receive(:call).and_return(monad)
      allow(monad).to receive(:success?).and_return(true)
      allow(monad).to receive(:value!)
    end

    describe "POST /report" do
      it "returns http success" do
        post "/report", params: params
        expect(response).to have_http_status(:success)
      end

      it "call query" do
        expect(Report).to receive(:call)
        post "/report", params: params
      end
    end
  end

end
