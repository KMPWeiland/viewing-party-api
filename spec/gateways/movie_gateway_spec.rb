require "rails_helper"

RSpec.describe MovieGateway do
  it "should make call to TMDB to retrieve TOP movie data", :vcr do
    VCR.use_cassette("should_make_call_to_TMDB_to_retrieve_TOP_movie_data") do
  
      movies = MovieGateway.top_rated 
      # unit tests for each element/method
      expect(movies[0].id).not_to be_nil 
      expect(movies[0]).to be_an_instance_of Movie
      expect(movies[0].type).to eq("movie")
      expect(movies[0].vote_average).not_to be_nil 
    end
  end

  describe '.fetch_movie_details' do

    it "should make a call to TMDB to retrieve movie data by movie id", :vcr do
      VCR.use_cassette("should_make_call_to_TMDB_to_retrieve_movie_data_by_id") do
    
        movie_id = MovieGateway.top_rated.first.id 
        # binding.pry
        response_body = MovieGateway.fetch_movie_details(movie_id)
        
        expect(response_body.id).not_to be_nil 
        expect(response_body.type).to eq("movie")
        expect(response_body).to be_an_instance_of Movie
        # expect(response_body.cast).to be_an(Array)
        expect(response_body.release_date).not_to be_nil 
        expect(response_body.title).not_to be_nil 
        expect(response_body.vote_average).not_to be_nil 
        expect(response_body.runtime).not_to be_nil 
        expect(response_body.genres).not_to be_nil 
        expect(response_body.summary).not_to be_nil 
        # expect(response_body.cast).not_to be_nil
        
      end
    end
  end
  
end



  # describe '.top_rated' do
  #   it 'returns a list of Movie objects' do
  #     # Mock the API response
  #     api_response = {
  #       results: [
  #         { id: 278, title: "The Shawshank Redemption", vote_average: 8.708 },
  #         { id: 238, title: "The Godfather", vote_average: 8.688 }
  #         # Add more mock movies as needed
  #       ]
  #     }.to_json

  #     # Stub the API call
  #     allow(MovieGateway).to receive(:connect_to_api).and_return(JSON.parse(api_response, symbolize_names: true))

  #     # Call the method
  #     movies = MovieGateway.top_rated

  #     # Expectations
  #     expect(movies).to all(be_a(Movie))
  #     expect(movies.first.id).to eq("278")
  #     expect(movies.first.title).to eq("The Shawshank Redemption")
  #     expect(movies.first.vote_average).to eq(8.708)
  #   end

  #   it 'handles API errors gracefully' do
  #     # Simulate an error response
  #     allow(MovieGateway).to receive(:connect_to_api).and_raise(StandardError.new("API Error"))

  #     # Expect an error to be raised or handled
  #     expect { MovieGateway.top_rated }.to raise_error(StandardError, "API Error")
  #   end
  # end
