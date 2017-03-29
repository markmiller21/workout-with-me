class UserActivity < ActiveRecord::Base
  self.table_name = "user_activities"
  belongs_to :user
  belongs_to :activity
end