class MessagesController < ApplicationController
  before_action :message_attributes, only: [:create]
  def index
    @match = Match.find(params[:match_id])
    @messages = Message.all
  end

  def create
    # Message.create(sender_id: current_user.id, reciever_id: )
    @message = Message.create!(message_attributes)
  end

  private

  def message_attributes
    params.require(:message).permit(:content)
  end
end