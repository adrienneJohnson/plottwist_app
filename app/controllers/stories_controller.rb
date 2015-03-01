class StoriesController <ApplicationController
  before_filter :authenticate_user!

  def new
    @story = Story.new
    @creator = current_user
  end
    
  def create
    @story = current_user.stories.build(story_params)    
    if @story.save
      flash[:notice] = "You're off to a great start."
      redirect_to user_path(current_user)
    else
      flash[:alert] = "There was a problem."
      render :new
    end
  end

  def show
    @story = Story.find_by_id(params[:id])
    @users = @story.users.all
  end
end

private

def story_params
  params.require(:story).permit(:title, :description)
end

