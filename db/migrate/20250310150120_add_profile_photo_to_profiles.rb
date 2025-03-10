class AddProfilePhotoToProfiles < ActiveRecord::Migration[7.2]
  def change
    def change
      add_column :profiles, :profile_photo, :string
    end
  end
end
