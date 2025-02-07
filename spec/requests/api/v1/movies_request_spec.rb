require "rails_helper"

RSpec.describe "Movies Endpoints" do
  context "top_rated" do
    describe "happy path" do
      it "can retrieve a list of the top rated movies" do
        get "/api/v1/movies/top_rated"

        expect(response).to be_successful
        
        json = JSON.parse(response.body, symbolize_names: true)
        #when i hit this endpoint this is what i want the response to be = integration test
   
        expect(json[:data][0][:id]).to be_a(String)
        expect(json[:data][0][:type]).to eq("movie")
        expect(json[:data][0][:attributes]).to have_key(:title)
        expect(json[:data][0][:attributes]).to have_key(:vote_average)
      end
    end
  end

  context "search" do
    describe "happy path" do
      it "can can retrieve a list of the movies that satisfy the search query" do
        get "/api/v1/movies/search", params: { query: "Inception" }

        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)

   
        expect(json[:data][0][:id]).to be_a(String)
        expect(json[:data][0][:type]).to eq("movie")
        expect(json[:data][0][:attributes]).to have_key(:title)
        expect(json[:data][0][:attributes]).to have_key(:vote_average)
      end
    end
  end
end