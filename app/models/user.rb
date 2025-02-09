class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, 
          :jwt_authenticatable, jwt_revocation_strategy: self

  enum user_role: { international_student: 'international_student', buddy: 'buddy', admin: 'admin' }
  
  before_create :set_user_role_based_on_email
  # after_create :create_profile

  has_many :posts
  has_many :discussions
  has_many :comments

  has_one :profile
  accepts_nested_attributes_for :profile

  has_many :bookmarks
  has_many :bookmarked_posts, through: :bookmarks, source: :bookmarkable, source_type: 'Post'
  has_many :bookmarked_discussions, through: :bookmarks, source: :bookmarkable, source_type: 'Discussion'
  
  has_one :application_form_as_student, class_name: 'ApplicationForm', foreign_key: 'student_id'
  has_many :application_forms_as_buddy, class_name: 'ApplicationForm', foreign_key: 'buddy_id'

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@edu\.hse\.ru\z/, message: :invalid_domain }

  private

  # def create_profile
  #   Profile.find_or_create_by(user: self)
  # end
  
  def set_user_role_based_on_email
    return if user_role.present?

    if email.start_with?('student')
      self.user_role = 'international_student'
    elsif email.start_with?('buddy')
      self.user_role = 'buddy'
    elsif email.start_with?('admin')
      self.user_role = 'admin'
    end
  end

end
