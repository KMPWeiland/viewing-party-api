class ViewingParty < ApplicationRecord
  has_many :user_viewing_parties
  has_many :users, through: :user_viewing_parties

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
    puts "Viewing party created: #{viewing_party}"

    # binding.pry

    host = find_and_validate_host!(invitees, viewing_party)
    puts "Host found: #{host}"
   
    # raise ActiveRecord::RecordInvalid.new(self.new), "Host user not found" if host.nil 
    # UserViewingParty.create!(viewing_party: viewing_party, user: host, is_host: true)
    # if new_viewing_party.persisted? #successfully saved? to prevent associating users w/ non-existent viewing parties
    # end

    puts "Invitees before association with VP: #{invitees}"
    associate_user_with_viewing_party(viewing_party, invitees, host)
    # host_id = host.id
    # invitees.each do |invitee_id|
    #   next if invitee_id == host_id
    #   invitee = User.find_by(id: invitee_id)
    #   UserViewingParty.create!(viewing_party: viewing_party, user: invitee, is_host: false) if invitee
    # end
    puts "Users associated"
    puts "Invitees after association with VP: #{invitees}"
    puts "Viewing party : #{viewing_party}" 

    viewing_party
  end

  private

  def self.permit_params(params)
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title)
  end

  def self.extract_invitees(params)
    params[:invitees].map(&:to_i) || []
  end

  def self.find_and_validate_host!(invitees, viewing_party)
    host_id = invitees.first 
    host = User.find_by(id: host_id)
    raise ActiveRecord::RecordInvalid.new(viewing_party), "Host user not found" if host.nil?
    host
  end

  def self.associate_user_with_viewing_party(viewing_party, invitees, host)
    the_host_id = host.id
    puts "Processing invitees: #{invitees}"
    puts "Host ID: #{the_host_id}"  

    invitees << host_id unless invitees.include?(the_host_id)

    invitees.each do |invitee_id|
      # next if invitee_id == the_host_id
      invitee = User.find_by(id: invitee_id)
      puts "Associating invitee: #{invitee_id}" if invitee
      is_host = (invitee_id == the_host_id)
      UserViewingParty.create!(viewing_party: viewing_party, user: invitee, is_host: false) if invitee
    end
  end

  def self.create_user_viewing_party!(viewing_party, user, is_host)
    UserViewingParty.create!(viewing_party: viewing_party, user: host, is_host: true)
  end


 
end


# has_many :enrollments
# has_many :courses, through: :enrollments
# has_many :teachers, through: :courses

# validates :name, presence: true