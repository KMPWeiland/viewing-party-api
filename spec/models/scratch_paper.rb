#user_viewing_party
class UserViewingParty < ApplicationRecord
  # validates :user, presence: true
  # validates :viewing_party, presence: true 
  belongs_to :user
  belongs_to :viewing_party

  validates :user, presence: true
end


#viewing_party controller
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




#viewing_party model
class ViewingParty < ApplicationRecord
  has_many :users, through: :user_viewing_parties
  has_many :user_viewing_parties

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true
  # validates :host_user_id, presence: true

  def self.create_with_invitees!(params)
    permitted_params = permit_params(params)
   
    invitees = self.extract_invitees(params)
 
    viewing_party = create_viewing_party!(permitted_params)
 
    host = find_and_validate_host!(invitees, viewing_party)
    
    associate_user_with_viewing_party(viewing_party, invitees, host)
   
    viewing_party
  end

  private

  def self.permit_params(params)
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title, invitees: [])
  end

  def self.extract_invitees(params)
    # invitees = params[:invitees].map(&:to_i) || []
    invitees = (params[:invitees] || []).map(&:to_i)
  end

  def self.create_viewing_party!(permitted_params)
    ViewingParty.create!(permitted_params)
  end

  def self.find_and_validate_host!(invitees, viewing_party)
    host_id = invitees.first 
    host = User.find_by(id: host_id)
    raise ActiveRecord::RecordInvalid.new(viewing_party), "Host user not found" if host.nil?
  end

  def self.associate_user_with_viewing_party(viewing_party, invitees, host)
    host_id = invitees.first 
    create_user_viewing_party(viewing_party, host, true)
    invitees.each do |invitee_id|
      next if invitee_id == host_id
      invitee = User.find_by(id: invitee_id)
      create_user_viewing_party(viewing_party, invitee, false) if invitee
    end
  end

  def self.create_user_viewing_party(viewing_party, user, is_host)
    UserViewingParty.create!(
      viewing_party: viewing_party,
      user: user, 
      is_host: is_host
    ) 
  end
 
end



#viewing_parties_request_spec
require "rails_helper"

RSpec.describe "Viewing Party API", type: :request do
  before(:each) do
    @user = User.create!(id: 1, name: "John Doe", username: "johndoe", password: "password")
    # @user2 = User.create!(id: 2, name: "John Doe2", username: "johndoe2", password: "password2")
  end
  
  it "creates a viewing party" do
    viewing_party_params = {
      "name": "CJ's partay", 
      "start_time": "2025-02-01 10:00:00", 
      "end_time": "2025-02-01 14:30:00", 
      "movie_id": 278,
      "movie_title": "The Shawshank Redemption",
      "invitees": ["11", "7", "5"]
    }
    post "/api/v1/viewing_parties", params: viewing_party_params 
    
    expect(response).to have_http_status(:created) 
    
    json = JSON.parse(response.body, symbolize_names: true)
  
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:type]).to eq("viewing_party")
    expect(json[:data][:attributes][:name]).to eq("CJ's partay")
    expect(json[:data][:attributes][:movie_id]).to eq(278)
    expect(json[:data][:attributes][:invitees][0][:id]).to eq(11)
  end
end 
