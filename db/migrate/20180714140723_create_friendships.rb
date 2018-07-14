class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :requestor_id
      t.integer :requested_id
      t.boolean :accepted

      t.timestamps
    end

    add_index :friendships, :requestor_id
    add_index :friendships, :requested_id
    
    #unique pairs, can't rerequest if already exists
    add_index :friendships, [:requestor_id, :requested_id], unique: true
    add_index :friendships, [:requested_id, :requestor_id], unique: true
  end
end
