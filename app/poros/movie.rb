class Movie
  attr_reader :id, :type, :title, :vote_average, :summary, :release_date, :runtime, :genres, :cast

  def initialize(data)
    @id = data[:id].to_s
    @type = "movie"
    @title = data[:title], 
    @vote_average = data[:vote_average] 
    @summary = data[:overview] if data[:overview]
    @release_date = data[:release_date] if data[:release_date]
    @runtime = data[:runtime] if data[:runtime]
    @genres = data[:genres]&.map { |genre| genre[:name] } || []
    # binding.pry
    # @cast = data[:credits][:cast]&.map { |cast_member| cast_member[:character] } || []
    # , cast_member[:name]
  end 

  # attr_reader :id, :type, :attributes, :title, :vote_average 

  # def initialize(data)
  #   @id = data[:id].to_s
  #   @type = "movie"
  #   @attributes = { title: @title = data[:title], 
  #     vote_average: @vote_average = data[:vote_average]}    
  # end

  #looking at individual object
end