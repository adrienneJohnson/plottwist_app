class InvitesController <ApplicationController

def index
end


  def new
    @invite = Invite.new
    @story = Story.find_by_id(params[:story_id])
  end

  def create
    @invite = Invite.new(invite_params) 
    @invite.sender_id = current_user.id
    if @invite.save
      if @invite.recipient != nil 
        InviteMailer.existing_user_invite(@invite).deliver 
        @invite.recipient.stories.push(@invite.story)
      else
        InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver
      end
    end
  end
end

private

def invite_params
  params.require(:invite).permit(:email, :sender_id)
end

