class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
    	t.references :initiator, null: false
    	t.references :responder, null: false
    	t.boolean :accepted, default: false

    	t.timestamps null: false
    end
  end
end
