class RemoveSenderIdintegerFromInvites < ActiveRecord::Migration
  def change
    remove_column :invites, :sender_idinteger, :string
  end
end
