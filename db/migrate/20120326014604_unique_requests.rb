class UniqueRequests < ActiveRecord::Migration
  def change
    add_index :requests, [:user_id, :youtube_id], :name => :unique_user_and_video, :unique => true
  end
end
