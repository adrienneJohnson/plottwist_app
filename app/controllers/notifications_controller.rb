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

  def process_sms
    @body = params[:Body]
    @user = User.find_by_phone(params[:From][2..-1])
    @user_id = @user.id
    @story_id = @user.memberships.first.story_id
    @line = Line.create(body: @body, user_id: @user_id, story_id: @story_id)  
      if @line.save
        @story = Story.find_by_id(@story_id)
        if @user == @story.memberships.first.user
          client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
          message = client.messages.create from: '2013808485', to: @story.memberships.second.user.phone, body: @story.lines.last.body
          render plain: message.status
        elsif @user == @story.memberships.second.user && @story.memberships.second.user != @story.memberships.last.user
          client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
          message = client.messages.create from: '2013808485', to: @story.memberships.third.user.phone, body: @story.lines.last.body
          render plain: message.status
        elsif @user == @story.memberships.second.user && @story.memberships.second.user == @story.memberships.last.user
          client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
          message = client.messages.create from: '2013808485', to: @story.memberships.first.user.phone, body: @story.lines.last.body
          render plain: message.status
        elsif @user == @story.memberships.third.user && @story.memberships.third.user != @story.memberships.last.user
          client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
          message = client.messages.create from: '2013808485', to: @story.memberships.fourth.user.phone, body: @story.lines.last.body
          render plain: message.status
        elsif @user == @story.memberships.third.user && @story.memberships.third.user == @story.memberships.last.user
          client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
          message = client.messages.create from: '2013808485', to: @story.memberships.first.user.phone, body: @story.lines.last.body
          render plain: message.status
        elsif @user == @story.memberships.fourth.user && @story.memberships.fourth.user != @story.memberships.last.user
          client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
          message = client.messages.create from: '2013808485', to: @story.memberships.fifth.user.phone, body: @story.lines.last.body
          render plain: message.status
        elsif @user == @story.memberships.fourth.user && @story.memberships.fourth.user == @story.memberships.last.user
          client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
          message = client.messages.create from: '2013808485', to: @story.memberships.first.user.phone, body: @story.lines.last.body
          render plain: message.status
        elsif @user == @story.memberships.fifth.user
          client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
          message = client.messages.create from: '2013808485', to: @story.memberships.first.user.phone, body: @story.lines.last.body
          render plain: message.status
        end
      end
    end
  
end

