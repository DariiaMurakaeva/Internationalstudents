class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]

  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1 or /profiles/1.json
  def show
    @user = current_user
    if @user.international_student?
      @created_discussions = @user.discussions
      @saved_posts = @user.bookmarked_posts
      @saved_discussions = @user.bookmarked_discussions
    elsif @user.buddy?
      @saved_posts = @user.bookmarked_posts
      @saved_discussions = @user.bookmarked_discussions
      @my_students = ApplicationForm.where(buddy_id: current_user.id)
    elsif @user.admin?
      @all_posts = Post.all
      @all_discussions = Discussion.all
    end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.destroy!

    respond_to do |format|
      format.html { redirect_to profiles_path, status: :see_other, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def content
    user = current_user
    content_type = params[:content_type]
    category = params[:category]

    if content_type == "created"
      @content = case category
        when "posts"
          user.admin? ? Post.all : []
        when "discussions"
          user.discussions
        end
    else # saved content
      @content = case category
        when "posts"
          user.bookmarked_posts
        when "discussions"
          user.bookmarked_discussions
        end
    end

    Rails.logger.debug "Content type: #{content_type}, Category: #{category}"
    Rails.logger.debug "Content: #{@content.inspect}"

    render json: { html: render_to_string(partial: "#{content_type}_#{category}", locals: { content: @content }) }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :date_of_birth, :faculty, :country, :languages, :program_type, :profile_photo)
    end
end
