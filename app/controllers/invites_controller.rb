class InvitesController <ApplicationController

  def new
    @invite = Invite.new
    @story = Story.find_by_id(params[:id])
  end

  def create
    @invite = Invite.new(invite_params) 
    @invite.sender_id = current_user.id
    if @invite.save
      InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver #send the invite data to our mailer to deliver the email
    else
    end
  end
end

private

def invite_params
  params.require(:invite).permit(:email, :sender_id)
end

