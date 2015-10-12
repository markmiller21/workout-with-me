class AddAttachmentAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :avatar # Jenny we need to do something with the default here... Currently it's ------- default:
    end
  end

  def self.down
    remove_attachment :users, :avatar
  end
end
