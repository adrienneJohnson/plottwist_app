class MembershipsController < ApplicationController
def new
    @story = Story.find_by_id(params[:id])
    if params[:search]
      @users = User.search(params[:search])
    end
    @invite = Invite.new
    @membership = Membership.new
  end

  def create
    @story = Story.find_by_id(params[:id])
    @membership = Membership.new(membership_params)
    if @membership.save
      flash[:notice] = "Added writer."
      redirect_to "/"
    end
  end
end
  
private

def membership_params
    params.require(:membership).permit(:story_id, :user_id)
end

