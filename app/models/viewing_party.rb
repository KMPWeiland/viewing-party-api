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
    puts "Params permitted: #{permitted_params}"

    invitees = extract_invitees(params)
    puts "Invitees extracted: #{invitees}"


    viewing_party = ViewingParty.create!(permitted_params)
    puts "Viewing party created: #{viewing_party.id}"


    host_id = invitees.first 
    host = User.find_by(id: host_id)
    raise ActiveRecord::RecordInvalid.new(viewing_party), "Host user not found" if host.nil?
    puts "Host found: #{host.id}"
    # raise ActiveRecord::RecordInvalid.new(self.new), "Host user not found" if host.nil 

    UserViewingParty.create!(viewing_party: viewing_party, user: host, is_host: true)
    

    # if new_viewing_party.persisted? #successfully saved? to prevent associating users w/ non-existent viewing parties
    # end
    invitees.each do |invitee_id|
      next if invitee_id == host_id
      invitee = User.find_by(id: invitee_id)
      UserViewingParty.create!(viewing_party: viewing_party, user: invitee, is_host: false) if invitee
    end
    puts "Users associated"


    viewing_party

  end

  private

  def self.permit_params(params)
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title)
  end

  def self.extract_invitees(params)
    params[:invitees].map(&:to_i) || []
  end


 
end


# has_many :enrollments
# has_many :courses, through: :enrollments
# has_many :teachers, through: :courses

# validates :name, presence: true