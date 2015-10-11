class Message < ActiveRecord::Base
belongs_to :accepter, :class_name => 'User'
belongs_to :receiver, :class_name => 'User'

end
