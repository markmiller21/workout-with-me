class AddPhotoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :avatar, :string, default: "http://prepgenie.ie/gamsat/wp-content/uploads/2015/08/default-avatar_man.png"
  end
end
