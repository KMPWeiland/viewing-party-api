class Api::V1::MoviesController < ApplicationController

  def top_rated
    movies = MovieGateway.top_rated
    render json: MovieSerializer.format_movies(movies)
  end

  def search
    query = params[:query]
    if query.present?
      movies = MovieGateway.search(query)
      render json: MovieSerializer.format_movies(movies)
    else
      render json: { error: 'Query parameter is required' }, status: :bad_request
    end
  end

  def details
    movie_id = params[:id]
    if movie_id.present?
      movie = MovieGateway.fetch_movie_details(movie_id)
      render json: MovieSerializer.format_movie_data(movie)
    else
      render json: { error: 'Movie ID is required' }, status: :bad_request
    end
  end




end
 










  
