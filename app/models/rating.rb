class Rating < ActiveRecord::Base
  belongs_to :ratee, :class_name => 'User'
  belongs_to :rater, :class_name => 'User'

  validates :rank, :presence => true
  validates :ratee, :presence => true
  validates :rater, :presence => true

  def match
    Match.where(initiator_id: [self.rater.id, self.ratee.id], responder_id: [self.rater.id, self.ratee.id], accepted: 1)
  end

  def already_exists?
    Rating.where(rater_id: self.rater.id, ratee_id: self.ratee.id) != []
  end

end