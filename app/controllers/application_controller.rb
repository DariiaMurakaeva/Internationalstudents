class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  def authenticate_guest 
    if cookies[:guest_token]
      jti = cookies[:guest_token]
      @guest = Guest.find_by_jti(jti)

      puts "GUEST TOKEN"
      puts jti
    else
      puts "NO TOKEN"
      jti = SecureRandom.uuid
      @guest = Guest.create!(jti: jti)
      cookies[:guest_token] = jti
    end

    # cookies.delete(:guest_token)
  end
end
