class UsersController <ApplicationController
  before_filter :authenticate_user!
  
  def index
    @users = User.all
  end

  def show
    @stories = current_user.stories.all
  end
end
