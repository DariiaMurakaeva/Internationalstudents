class Profile < ApplicationRecord

    belongs_to :user
    has_one_attached :profile_photo

    validates :faculty, presence: true
    validates :date_of_birth, presence: true
    validates :country, presence: true
    validates :languages, presence: true
    validates :program_type, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true

    def name
        "#{first_name} #{last_name}"
    end

    def formatted_languages
        languages.split(',').join(' / ')
    end

    def profile_photo_url
        Rails.application.routes.url_helpers.url_for(profile_photo) if profile_photo.attached?
    end
end
