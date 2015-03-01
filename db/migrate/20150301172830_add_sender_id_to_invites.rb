class AddSenderIdToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :sender_id, :integer
  end
end
