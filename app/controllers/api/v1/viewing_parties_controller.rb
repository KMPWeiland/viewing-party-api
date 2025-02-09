class Api::V1::ViewingPartiesController < ApplicationController

  def create
    name = params[:name] 
    start_time = params[:start_time] 
    end_time = params[:end_time]
    movie_id = params[:movie_id] 
    movie_title = params[:movie_title] 
    invitees = params[:invitees].map(&:to_i) || []


    #validate required params    
    if name.blank? 
      return render json: { error: "Please provide a name for your viewing party" }, status: :unprocessable_entity
    end
    if movie_title.blank? || movie_id.blank?
      return render json: { error: "Both movie_id and move_name must be provided" }, status: :unprocessable_entity
    end
    if start_time.blank? || end_time.blank? 
      return render json: { error: "Both start_time and end_time must be provided" }, status: :unprocessable_entity
    end
    if invitees.blank?  
      return render json: { error: "Please add invitees to your viewing party" }, status: :unprocessable_entity
    end

    #find host user
    host_id = invitees.first 
    host = User.find_by(id: host_id)
    return render json: { error: "Host user not found" }, status: :unprocessable_entity if host.nil?

    #create a new viewing party
    new_viewing_party = ViewingParty.create!(viewing_party_params)

    #associate users with Viewing Party
    if new_viewing_party.persisted?
      invitees.each do |invitee_id|
        invitee = User.find_by(id: invitee_id)
        if invitee
          UserViewingParty.create!(
            viewing_party: new_viewing_party, 
            user: invitee, 
            is_host: invitee.id == host.id
          )   
        end        
      end
      
      #render success response
      render json: ViewingPartySerializer.format_viewing_party(new_viewing_party), status: :created

      # render json: {
      #   data: {
      #     id: new_viewing_party.id.to_s,
      #     type: "viewing_party",
      #     attributes: {
      #       name: new_viewing_party.name, 
      #       start_time: new_viewing_party.start_time,
      #       end_time: new_viewing_party.end_time,
      #       movie_id: new_viewing_party.movie_id,
      #       movie_title: new_viewing_party.movie_title,
      #       invitees: User.where(id: invitees).map do |user| {
      #         id: user.id,
      #         name: user.name, 
      #         username: user.username
      #       }
      #       end
      #     }
      #   }
      # }, status: :created
    else
      Rails.logger.error("Viewing Party creation failed: #{new_viewing_party.errors.full_messages}")
      render json: { errors: new_viewing_party.errors.full_messages }, status: :unprocessable_entity
    end
    # else
    #   render json: { errors: viewing_party.errors.full_messages }, status: :unprocessable_entity
    # end
  end


  private

  def viewing_party_params
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title)
  end

end

 
     # # host = User.find(params[user:id]
    # # viewing_parties/user_id...

    # #create viewing party
    # viewing_party = ViewingParty.new(
    #   name: name,
    #   start_time: start_time, 
    #   end_time: end_time, 
    #   movie_id: movie_id,
    #   movie_title: movie_title
    # )

  # def create 
  #   merchant = Merchant.find(params[:merchant_id])
  #   coupon = merchant.coupons.new(coupon_params)

  #   if coupon.save
  #     render json: CouponSerializer.new(coupon), status: :created
  #   else
  #     render json: { error: coupon.errors.full_messages.to_sentence }, status: :unprocessable_entity
  #   end
  # end

  # def index
  #   render json: ViewingPartySerializer.format_user_list(ViewingParty.all)
  # end


    #create nested route: /api/vi/users/1/viewing_parties
    # user = User.find(params[:user_id]) 

    # movie = MovieGateway.fetch_movie_details(params[:movies])


    # user = User....?
    # # In the Controller: Within the ⁠create method of your ⁠ViewingPartyController call a gateway method (e.g., ⁠fetch_movie_details) to retrieve movie data from an external API as part of the viewing party creation logic. see images_controller in set_list_api
    # viewing_party = ViewingParty.new(viewing_party_params)
    # if viewing_party.save
    #   render json: ViewingPartySerializer.new(viewing_party), status: :created
    # else
    #   render json: ErrorSerializer.format_error(ErrorMessage.new(user.errors.full_messages.to_sentence, 400)), status: :bad_request
    # end