class MovieGateway
  def self.top_rated
    movies = connect_to_api("/3/movie/top_rated", { language:
     "en-US", page: 1 })[:results]
    movies.map { |movie| Movie.new(movie) }
    #when you're trying to define attributes for an object that doesn't exist in your schema it MUST be defined as a PORO
  end

  def self.search(query)
    response = connect_to_api("/3/search/movie", { query: query, language: "en-US", page: 1, include_adult: false })
    movies = response[:results]
    movies.map { |movie| Movie.new(movie) }    
  end

  private

  def self.connect_to_api(endpoint, parameters = {})
    response = connect.get(endpoint) do |req|
      req.params = parameters
      req.params[:api_key] = Rails.application.credentials[:tmdb][:api_key]
    end

    parse_response(response)
  end

  def self.parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end


  def self.connect 
    Faraday.new(url: "https://api.themoviedb.org")
  end

end

#call, response, connection, format