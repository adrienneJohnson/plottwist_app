class NotificationsController < ApplicationController
   skip_before_action :verify_authenticity_token

  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '2013808485', to: '6467374927', body: 'Learning to send SMS you are.'
    render plain: message.status
  end

  def start
    @story = Story.find(params[:story_id])
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '2013808485', to: @story.memberships.second.user.phone, body: @story.first_line
    render plain: message.status
  end
end