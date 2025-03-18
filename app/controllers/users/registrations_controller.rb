# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def sign_up_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      profile_attributes: [:first_name,:last_name, :faculty, :date_of_birth, :country, :languages, :program_type, :profile_photo]
    )
  end

  def create
    build_resource(sign_up_params)
  
    if resource.save
      sign_up(resource_name, resource)
      respond_with resource, location: root_url(resource)
    else
      Rails.logger.error "User save failed: #{resource.errors.full_messages}"
      Rails.logger.error "Profile errors: #{resource.profile.errors.full_messages if resource.profile}"
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def new
    build_resource
    resource.build_profile
    respond_with resource
  end

  def after_sign_up_path_for(resource)
    root_url(resource)
  end

end
