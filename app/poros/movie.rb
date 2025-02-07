class Movie
  attr_reader :id, :type, :title, :vote_average 

  def initialize(data)
    @id = data[:id].to_s
    @type = "movie"
    @title = data[:title]
    @vote_average = data[:vote_average]
  end

  #looking at individual object

end