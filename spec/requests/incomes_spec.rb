require 'rails_helper'

RSpec.describe "Incomes", type: :request do
  describe "GET /create" do
    it "returns http success" do
      post "/income"
      expect(response).to have_http_status(:success)
    end
  end

end
