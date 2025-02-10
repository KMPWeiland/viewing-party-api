require "rails_helper"

RSpec.describe "Viewing Party API", type: :request do
  before(:each) do
    # DatabaseCleaner.clean_with(:truncation)  # Make sure we start clean
    @user = User.create!(id: 1, name: "John Doe", username: "johndoe", password: "password")
  end
  
  it "creates a viewing party" do
    viewing_party_params = {
      "name": "CJ's partay", 
      "start_time": "2025-02-01 10:00:00", 
      "end_time": "2025-02-01 14:30:00", 
      "movie_id": 278,
      "movie_title": "The Shawshank Redemption",
      "invitees": ["11", "7", "5"]
    }
    
    post "/api/v1/viewing_parties", params: viewing_party_params 
    
    expect(response).to have_http_status(:created) 
    
    json = JSON.parse(response.body, symbolize_names: true)
  
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:type]).to eq("viewing_party")
    expect(json[:data][:attributes][:name]).to eq("CJ's partay")
    expect(json[:data][:attributes][:movie_id]).to eq(278)
    # binding.pry
    expect(json[:data][:attributes][:invitees][0][:id]).to eq(11)
  end
end 
