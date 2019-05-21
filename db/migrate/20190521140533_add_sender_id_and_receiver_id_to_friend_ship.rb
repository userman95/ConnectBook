class AddSenderIdAndReceiverIdToFriendShip < ActiveRecord::Migration[5.2]
  def change
    add_reference :friendships, :sender, foreign_key: { to_table: :users }
    add_reference :friendships, :receiver, foreign_key: { to_table: :users }
    add_index :friendships, [:sender_id, :receiver_id], unique: true
  end
end
