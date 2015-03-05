class UsersController <ApplicationController
  before_filter :authenticate_user!
  layout "user_page_layout"
  
  def index
    @users = User.all
  end

  def show
    @user = current_user
    @stories = @user.stories.all
  end
end
