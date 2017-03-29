class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
    	t.belongs_to :activity, null: false
    	t.belongs_to :user, null: false

    	t.timestamps null: false
    end
  end
end
