class MembershipsController < ApplicationController
def new
    @story = Story.find_by_id(params[:id])
    if params[:search]
      @users = User.search(params[:search])
    end
    @invite = Invite.new
  end

  def create
    @story = Story.find_by_id(params[:id])
    @membership = Membership.new(membership_params)
  end
end
  
  private

def membership_params
    params.require(:membership).merge(story_id: params[:story_id], user_id: params[:user_id])
end

