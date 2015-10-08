class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
    	t.integer :rank, null: false
    	t.references :ratee, null: false
    	t.references :rater, null: false

    	t.timestamps null: false
    end
  end
end
