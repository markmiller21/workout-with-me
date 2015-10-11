class User < ActiveRecord::Base
	has_many :user_activities
	has_many :activities, through: :user_activities
	has_many :ratee_ratings, :class_name => 'Rating', :foreign_key => 'ratee_id'
	has_many :rater_ratings, :class_name => 'Rating', :foreign_key => 'rater_id'

	has_many :initiator_matches, :class_name => 'Match', :foreign_key => "initiator_id"
	has_many :responder_matches, :class_name => 'Match', :foreign_key => "responder_id"

	validates :name, :email, :gender, :presence => true

	has_secure_password

  def average_rating
    all_ratings = Rating.where(ratee_id: self.id).map do |rating|
      rating.rank
    end
    all_ratings.inject { |sum, rating| sum + rating }
  end

end