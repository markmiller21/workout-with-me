class User < ActiveRecord::Base
	has_many :user_activities
	has_many :activities, through: :user_activities
	has_many :ratee_ratings, :class_name => 'Rating', :foreign_key => 'ratee_id'
	has_many :rater_ratings, :class_name => 'Rating', :foreign_key => 'rater_id'

	has_many :initiator_matches, :class_name => 'Match', :foreign_key => "initiator_id"
	has_many :responder_matches, :class_name => 'Match', :foreign_key => "responder_id"

  has_many :sender_messages, :class_name => 'Message', :foreign_key => "sender_id"
  has_many :receiver_messages, :class_name => 'Message', :foreign_key => "receiver_id"

  has_many :locations

	validates :name, :email, :gender, :presence => true

	has_secure_password

  def average_rating
    all_ratings = Rating.where(ratee_id: self.id).map do |rating|
      rating.rank
    end
    if all_ratings == []
      return "This user has no ratings yet"
    else
      sum_of_ratings = all_ratings.inject { |sum, rating| sum + rating }
      average = sum_of_ratings.to_f/(all_ratings.length).to_f
    end
  end

end