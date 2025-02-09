class UserViewingParty < ApplicationRecord
  # validates :user, presence: true
  # validates :viewing_party, presence: true 
  belongs_to :user
  belongs_to :viewing_party
end