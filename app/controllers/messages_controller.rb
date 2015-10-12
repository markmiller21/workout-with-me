class MessagesController < ApplicationController
  before_action :message_attributes, only: [:create]
  def index
    @match = Match.find(params[:match_id])
    @messages = @match.messages.all
  end

  def create
    @message = Message.create!(message_attributes)
  end

  private

  def message_attributes
    params.require(:message).permit(:content,:match_id,:sender_id,:receiver_id)
  end

end