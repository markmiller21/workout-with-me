class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content, null: false
      t.references :sender, null: false
      t.references :receiver, null: false
      t.references :match, null: false
      t.timestamps null: false
    end
  end
end
