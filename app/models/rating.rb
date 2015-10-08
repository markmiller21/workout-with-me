class Rating < ActiveRecord::Base
	has_many :ratee_ratings, :class_name => 'Rating', :foreign_key => 'ratee_id'
	has_many :rater_ratings, :class_name => 'Rating', :foreign_key => 'rater_id'

  belongs_to :ratee, :class_name => 'User'
  belongs_to :rater, :class_name => 'User'
end