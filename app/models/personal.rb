class Personal < ApplicationRecord
  belongs_to :student
  belongs_to :pref
  belongs_to :gakunen
  validates :student_id, uniqueness: true
end
