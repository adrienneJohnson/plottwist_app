class StoriesController <ApplicationController
  before_filter :authenticate_user!

  def new
    @story = Story.new
    @creator = current_user
  end
    
  def create
    @story = Story.new(story_params)
    @story.creator_id = current_user.id
    @story.users << current_user   
    if @story.save
      flash[:notice] = "You're off to a great start."
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Some information was missing. Try a second draft."
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
  params.require(:story).permit(:title, :description, :first_line)
end

