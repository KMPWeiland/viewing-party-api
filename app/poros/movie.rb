class Movie
  attr_reader :id, :type, :title, :vote_average 

  def initialize(data)
    @id = data[:id].to_s
    @type = "movie"
    @title = data[:title], 
    @vote_average = data[:vote_average]  
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