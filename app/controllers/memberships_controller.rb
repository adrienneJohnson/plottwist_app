class MembershipsController < ApplicationController
def new
    @story = Story.find_by_id(params[:id])
    if params[:search]
      @users = User.search(params[:search])
    end
    @membership = Membership.new
  end

  def create
    @story = Story.find(params[:story_id])
    @membership = @story.memberships.build(membership_params)
    if @membership.save
      flash[:notice] = "writer added."
      redirect_to story_path(@story)
    end
  end
end
  
private

def membership_params
    params.require(:membership).permit(:story_id, :user_id)
end

