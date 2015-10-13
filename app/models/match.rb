class Match < ActiveRecord::Base
	belongs_to :initiator, :class_name => 'User'
  belongs_to :responder, :class_name => 'User'
  has_many :messages

  validates :initiator, :responder, :presence => true


def calculate_distance(longitude,latitude)
end

end