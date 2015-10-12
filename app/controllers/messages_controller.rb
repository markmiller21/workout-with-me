class MessagesController < ApplicationController
  before_action :message_attributes, only: [:create]
  def index
    @match = Match.find(params[:match_id])
    @messages = @match.messages.all
  end

  def create
    # @match = Match.find_by(id: params[:id])
    @message = Message.create!(message_attributes)
  end

  private

  def message_attributes
    params.require(:message).permit(:content,:match_id)
  end
end