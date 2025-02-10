class ViewingPartySerializer
  def self.format_viewing_party(viewing_party_data)
    { 
    data: {
      id: viewing_party_data.id.to_s,
      type: "viewing_party",
      attributes: {
        name: viewing_party_data.name, 
        start_time: viewing_party_data.start_time,
        end_time: viewing_party_data.end_time,
        movie_id: viewing_party_data.movie_id,
        movie_title: viewing_party_data.movie_title,
        invitees: viewing_party_data.user_viewing_parties.map do |uvp| {
          id: uvp.user.id,
          name: uvp.user.name, 
          username: uvp.user.username
        }
        end
        }
      }
    }
  end

  def self.format_viewing_parties(viewing_parties)
    { 
    data: viewing_parties.map do |viewing_party| {
      id: viewing_party.id.to_s,
      type: "viewing_party",
      attributes: {
        name: viewing_party.name, 
        start_time: viewing_party.start_time,
        end_time: viewing_party.end_time,
        movie_id: viewing_party.movie_id,
        movie_title: viewing_party.movie_title,
        invitees: viewing_party.user_viewing_parties.map do |uvp| {
          id: uvp.user.id,
          name: uvp.user.name, 
          username: uvp.user.username
        }
        end
        }
      }
    end
    }
  end
end
