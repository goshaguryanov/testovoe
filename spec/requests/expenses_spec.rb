require 'rails_helper'

RSpec.describe "Expenses", type: :request do
  describe "POST /expense" do
    it "returns http success" do
      post "/expense"
      expect(response).to have_http_status(:success)
    end
  end

end
