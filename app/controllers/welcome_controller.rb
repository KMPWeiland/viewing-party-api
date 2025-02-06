class WelcomeController < ApplicationController

  def index
    render json: { message: "Hello World", time: Time.now }
  end

end
