class Rating < ActiveRecord::Base
  belongs_to :ratee, :class_name => 'User'
  belongs_to :rater, :class_name => 'User'

  validates :rank, :presence => true

  def self.average_rating(user)
    all_ratings = where(ratee_id: user.id).map do |rating|
      rating.rank
    end
    all_ratings.inject { |sum, rating| sum + rating }
  end

end