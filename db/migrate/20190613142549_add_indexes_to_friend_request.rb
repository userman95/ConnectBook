class AddIndexesToFriendRequest < ActiveRecord::Migration[5.2]
  def change
    add_index :friend_requests, [:user_id, :friend_id], unique: true
  end
end
