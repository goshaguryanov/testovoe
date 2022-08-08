require 'rails_helper'

RSpec.describe "Reports", type: :request do
  describe "POST /report" do
    it "returns http success" do
      post "/report"
      expect(response).to have_http_status(:success)
    end
  end

end
