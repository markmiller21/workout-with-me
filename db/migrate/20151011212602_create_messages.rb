class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.references :sender
      t.references :receiver
      t.references :match
    end
  end
end
