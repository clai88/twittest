class CreateFollowUsers < ActiveRecord::Migration
  def change
    create_table :follow_users do |t|
      t.integer :followee_id
      t.integer :follower_id

      t.timestamps null: false
    end
  end
end
