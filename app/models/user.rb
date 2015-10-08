class User < ActiveRecord::Base
	has_many :user_activites
	has_many :activities, through: :user_activites
	has_many :ratee_ratings, :class_name => 'Rating', :foreign_key => 'ratee_id'
	has_many :rater_ratings, :class_name => 'Rating', :foreign_key => 'rater_id'

	has_many :matches

	has_many :purchases, :class_name => 'Sale', :foreign_key => 'buyer_id'
  has_many :sales, :class_name => 'Sale', :foreign_key => 'seller_id'

end