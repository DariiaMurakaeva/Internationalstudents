class Profile < ApplicationRecord

    belongs_to :user
    
    validates :faculty, presence: true
    validates :date_of_birth, presence: true
    validates :country, presence: true
    validates :languages, presence: true
    validates :program_type, presence: true
    validates :name, presence: true
    validates :gender, presence: true, inclusion: { in: %w[М Ж] }
end
