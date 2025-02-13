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

  def self.format_movie_data(movie)
    { 
      data: 
      {
        id: movie.id,
        type: movie.type,
        attributes: {
          title: movie.title,
          vote_average: movie.vote_average, 
          runtime: movie.runtime,
          genres: movie.genres,
          summary: movie.summary
          # cast: movie.cast,
          # total_reviews: reviews.count
        }
      }
    }
  end
end
