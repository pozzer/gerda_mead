class ProfilesController < AppController
  def index
		@profiles = Profile.all
    respond_with(@profiles)
  end
end
