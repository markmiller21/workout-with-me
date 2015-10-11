class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.references :accepter
      t.references :receiver
    end
  end
end
