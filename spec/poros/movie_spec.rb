require "rails_helper"

Respec.describe Movie do
  it "should create a Move from JSON data" do
    
    sample_json = {
          "id": "278", // This ID is from the Movie DB API, not your local database
          "type": "movie",
          "attributes": {
            "title": "The Shawshank Redemption",
            "vote_average": 8.706
          }
    }

    movie = Movie.new(sample_json)
    expect(movie).to be_an_instance_of Movie
    expect(movie.id).to eq("278")
    expect(movie.type).to eq("movie")
    expect(movie.attributes.title).to eq("The Shawshank Redemption")
    expect(movie.attributes.vote_average).to eq(8.706)
  end
end