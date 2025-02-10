require "rails_helper"

RSpec.describe ViewingParty, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:movie_title) }
  end

  describe "relationships" do
    it { should have_many(:users).through(:user_viewing_parties)}
    it { should have_many(:user_viewing_parties)}
  end
  
  describe "specific attribute validations" do
     
    it "is valid when all attributes are present and valid" do

      # @user1 = User.create!(id: 11, name: "Barbara", username: "leo_fan", password: "password")
      # @user2 = User.create!(id: 7, name: "Ceci", username: "titanic_forever", password: "password")
      # @user3 = User.create!(id: 5, name: "Peyton", username: "star_wars_geek_8", password: "password") 

      @vp1 = ViewingParty.create!("name": "CJ's partay", "start_time": "2025-02-01 10:00:00", "end_time": "2025-02-01 14:30:00", "movie_id": 278, "movie_title": "The Shawshank Redemption")    

      expect(@vp1 ).to be_valid
      expect(@vp1 .persisted?).to be true
    end
  end

  describe "Instance methods" do
    describe '.create_with_invitees!' do
      xit 'creates a viewing party with valid attributes and invitees' do

        @vp1 = ViewingParty.create!("name": "CJ's partay", "start_time": "2025-02-01 10:00:00", "end_time": "2025-02-01 14:30:00", "movie_id": 278, "movie_title": "The Shawshank Redemption")    


        expect(@vp1).to be_persisted
        expect(@vp1.users).to include(@user1, @user2, @user3)
        # expect(viewing_party.user_viewing_parties.find_by(user: @user1).is_host).to be true
      end

      # xit 'raises an error if the host is not found' do
      #   #test assertions
      # end
    end
  end



end