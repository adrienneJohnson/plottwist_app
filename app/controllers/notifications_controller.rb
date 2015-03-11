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
    message = client.messages.create from: '2013808485', to: @story.memberships.second.user.phone, body: @story.first_line, to_zip: @story.id
    render plain: message.status
  end

  def process_sms
    @body = params[:Body]
    @user = User.find_by_phone(params[:From][2..-1])
    @user_id = @user.id
    @story_id = @user.memberships.first.story_id
    @line = Line.create(body: @body, user_id: @user_id, story_id: @story_id)  
    render 'twilio/process_sms.xml.erb', :content_type => 'text/xml'
  end
end

