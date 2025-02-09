class ViewingParty < ApplicationRecord
  has_many :users, through: :user_viewing_parties
  has_many :user_viewing_parties

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true
  # validates :host_user_id, presence: true
 
end


# has_many :enrollments
# has_many :courses, through: :enrollments
# has_many :teachers, through: :courses

# validates :name, presence: true