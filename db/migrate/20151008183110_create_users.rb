class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :name, null: false
    	t.string :email, null: false, limit: 100
    	t.string :password_digest, null: false
        t.string :gender, null: false
        t.string :description, limit: 500
    	t.integer :age, null: false, limit: 3
        t.string :gender_preference

    	t.timestamps null: false
    end
  end
end
