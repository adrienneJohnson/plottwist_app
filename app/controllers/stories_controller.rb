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
      flash[:notice] = "off to a great start!"
      redirect_to story_path(@story)
    else
      flash[:alert] = "some information was missing. try again."
      render :new
    end
  end

  def show
    @story = Story.find_by_id(params[:id])
    @users = @story.users.all
    @memberships = Membership.find_by_story_id(@story.id)
  end

  def destroy
    @story = Story.find_by_id(params[:id])
    @membership = Membership.find_by_story_id(@story)
    @story.destroy
    @membership.destroy
    flash[:notice] = "Story was deleted."
    redirect_to user_path(current_user)
  end


end



private

def story_params
  params.require(:story).permit(:title, :description, :first_line)
end

