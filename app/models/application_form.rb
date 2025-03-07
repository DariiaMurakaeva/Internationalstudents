class ApplicationForm < ApplicationRecord
  belongs_to :student, class_name: 'User', foreign_key: 'student_id', optional: true
  belongs_to :buddy, class_name: 'User', optional: true, foreign_key: 'buddy_id', optional: true

  validates :student_id, presence: true
  validates :about, :date_of_arrival, :time_of_arrival, :place_of_arrival, presence: true
end
