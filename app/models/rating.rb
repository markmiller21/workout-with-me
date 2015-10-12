class Rating < ActiveRecord::Base
  belongs_to :ratee, :class_name => 'User'
  belongs_to :rater, :class_name => 'User'

  validates :rank, :presence => true
  validates :ratee, :presence => true
  validates :rater, :presence => true

  def match
    if Match.find_by(initiator_id: self.rater.id, responder_id: self.ratee.id, accepted: 1)
      match = Match.find_by(initiator_id: self.rater.id, responder_id: self.ratee.id, accepted: 1)
    else
      match = Match.find_by(initiator_id: self.ratee.id, responder_id: self.rater.id, accepted: 1)
    end
  end

end