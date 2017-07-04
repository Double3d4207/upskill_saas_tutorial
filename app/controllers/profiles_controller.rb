class ProfilesController < ApplicationController
    
    # Get to /users/:user_id/profile/new
    def new
      # Render blank profiles details form
      @profile = Profile.new
    end
    
   # POST to /users/:user_id/profile
def create
  # Ensure that we have the user who is filling out form
  @user = User.find( params[:user_id] )
  # Create profile linked to this specific user
  @profile = @user.build_profile( profile_params )
  if @profile.save
    flash[:success] = "Profile updated!"
    redirect_to user_path(id: params[:user_id] )
  else
    render action: :new
  end
end

#GET to/users/:user_id/profile/edit
def edit
  @user = User.find( params[:user_id])
  @profile = @user.profile
end

# PUT to /user/:user_id/profile
def update
  # Retrieve the user from the database
  @user = User.find( params[:user_id])
  # Retrieve that users profile
  @profile = @user.profile
  # Mass assign edited profile attributes and save (Update)
  if @profile.update_attributes(profile_params)
    flash[:success] = "Profile updated!"
    # Redirect usert to their profile page
    redirect_to user_path(id: params[:user_id])
  else
    render action: :edit
  end
end

private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
  end
end