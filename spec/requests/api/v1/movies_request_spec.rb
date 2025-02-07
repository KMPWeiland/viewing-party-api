require "rails_helper"

RSpec.describe "Moves Endpoint" do
  describe "happy path" do
    it "can retrieve a list of the top rated movies" do
      get "/api/v1/movies/top_rated"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      # binding.pry
      expect(json[:data][0][:id]).to be_a(String)
      expect(json[:data][0][:type]).to eq("movie")
      expect(json[:data][0][:attributes]).to have_key(:title)
      expect(json[:data][0][:attributes]).to have_key(:vote_average)
    end
  end
end