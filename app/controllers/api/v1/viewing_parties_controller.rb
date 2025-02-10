class Api::V1::ViewingPartiesController < ApplicationController

  
  def index
    # binding.pry
    viewing_parties = ViewingParty.all
    render json: ViewingPartySerializer.format_viewing_parties(viewing_parties), status: :ok
  end

  
  def create
    new_viewing_party = ViewingParty.create_with_invitees!(params)
 
    render json: ViewingPartySerializer.format_viewing_party(new_viewing_party), status: :created

    rescue ActiveRecord::RecordInvalid => e 
      render json: { 
        status: "error", 
        message: e.record.errors.full_messages
      }, status: :unprocessable_entity
  end

  def add_user
    viewing_party = ViewingParty.find(params[:id])

    invitee_user_id = params.require(:invitees_user_id)

    user = User.find_by(id: invitee_user_id)
    unless user
      return render js: {error: 'User not found'}, status: :not_found
    end

    user_viewing_party = UserViewingParty.new(user_id: invitee_user_id, viewing_party_id: viewing_party.id, is_host: false)

    if user_viewing_party.save
      render json: { message: 'User added successfully'}, status: :ok
    else
      render json: { error: 'Failed to add user'}, 
      status: :unprocessable_entity
    end
  end



end
