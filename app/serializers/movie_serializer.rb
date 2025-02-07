class MovieSerializer
  def self.format_movies(movie_data)
    { 
      data: movie_data.map do |movie|
      {
        id: movie.id,
        type: movie.type,
        attributes: {
          title: movie.title,
          vote_average: movie.vote_average 
        }
      }
    end
  }
  end
end
