class Api::V1::ViewingPartiesController < ApplicationController

  def create
    new_viewing_party = ViewingParty.create_with_invitees!(params)
 
    render json: ViewingPartySerializer.format_viewing_party(new_viewing_party), status: :created


  rescue ActiveRecord::RecordInvalid => e 
    render json: { 
      status: "error", 
      message: e.record.errors.full_messages
    }, status: :unprocessable_entity

  end

end
 