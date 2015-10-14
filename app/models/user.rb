class User < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://prepgenie.ie/gamsat/wp-content/uploads/2015/08/default-avatar_man.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]
  has_many :user_activities
	has_many :activities, through: :user_activities
	has_many :ratee_ratings, :class_name => 'Rating', :foreign_key => 'ratee_id'
	has_many :rater_ratings, :class_name => 'Rating', :foreign_key => 'rater_id'

	has_many :initiator_matches, :class_name => 'Match', :foreign_key => "initiator_id"
	has_many :responder_matches, :class_name => 'Match', :foreign_key => "responder_id"

  has_many :sender_messages, :class_name => 'Message', :foreign_key => "sender_id"
  has_many :receiver_messages, :class_name => 'Message', :foreign_key => "receiver_id"

  has_many :locations

	validates :name,:gender, :presence => true
  validates :age, numericality: { only_integer: true }
  validates :email, uniqueness: true, :email_format => {:message => 'Invalid email address' }
  validates :description, length: { maximum: 500 }, allow_blank: true




	has_secure_password

  def get_potential_matches
    potential_matches = Hash.new
    self.activities.each do |activity|
      if self.gender_preference == "No preference"
        potential_users = activity.users
      else
        potential_users = activity.users.where(gender: self.gender_preference)
      end
        potential_users.each do |user|
          if self != user
            if potential_matches[user]
              potential_matches[user] += 1
            else
              potential_matches[user] = 1
            end
          end
        end
      end
    return potential_matches.sort {|a1,a2| a2[1]<=>a1[1]}
  end

  def find_next_match(potential_matches)
    for x in 0..potential_matches.length
      if Match.where(initiator_id: self.id, responder_id: potential_matches[x]) != []
        next
      elsif Match.where(initiator_id: potential_matches[x], responder_id: self.id, accepted: 1) != []
        next
      elsif Match.where(initiator_id: potential_matches[x], responder_id: self.id, accepted: -1) != []
        next
      else
        return potential_matches[x]
      end
    end
  end

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