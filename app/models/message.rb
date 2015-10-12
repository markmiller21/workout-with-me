class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  belongs_to :match

  validates :content, :presence => true
  # def sent_message?
  #   self.sender_id: self.id)
  #   @received_messages = Message.where(sender_id: @receiver.id, receiver_id: current_user.id)
end
