class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :story_id
      t.string :sender_idinteger
      t.integer :recipient_id
      t.string :token
      t.string :email

      t.timestamps null: false
    end
  end
end
