require "rails_helper"

RSpec.describe MovieGateway do
  it "should make call to TMDB to retrieve movie data" do
    # when testing gateways, think of the following:
    # INPUT 
    # OUTPUT 

    json_response = MovieGateway.top_rated 
    # binding.pry
    # expect(json_response[0].id).to eq("278")
    # expect(json_response[0]).to have_key :title
    # expect(json_response[0]).to have_key :type
    # expect(json_response[0]).to have_key :vote_average
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
end
