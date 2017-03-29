class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
    	t.references :initiator, null: false
    	t.references :responder, null: false
    	t.integer :accepted, default: 0

    	t.timestamps null: false
    end
  end
end
