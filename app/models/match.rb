class Match < ActiveRecord::Base
	belongs_to :initiator, :class_name => 'User'
  belongs_to :responder, :class_name => 'User'
  has_many :messages

  # validates :initiator_id, :responder_id, :presence => true
end