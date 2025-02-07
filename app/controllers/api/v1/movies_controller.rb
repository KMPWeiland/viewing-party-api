class Api::V1::MoviesController < ApplicationController
  # This endpoint should: 
    # 1. retrieve top-rated movies from The Movie DB API 
    # 2. retrieve a maximum of 20 results. 
    # 3. include the title and the vote average of every movie

    
  def top_rated
    # #verifying i have access, getting the key
    # conn = Faraday.new(url: "https://api.themoviedb.org/3") do |faraday|
    #   faraday.params[:api_key] = Rails.application.credentials.tmdb[:api_key]
    # end
    
    # #get to your room, all the data at the endpoing
    # response = conn.get("/movie/top_rated", { language: "en-US", page: 1 })
    
    # #parsing
    # json = JSON.parse(response.body, symbolize_names: true)
    # ----
    # #formatting
    # movies = json[:results].first(20).map do |movie|
    #   {
    #     title: movie[:title],
    #     vote_average: movie[:vote_average]
    #   }
    # end
    movies = MovieGateway.top_rated

    #rendering a response
    render json: { data: movies }
  end
end
 










  
