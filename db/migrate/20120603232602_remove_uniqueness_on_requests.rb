class RemoveUniquenessOnRequests < ActiveRecord::Migration
  def up
    remove_index "requests", :name => "unique_user_and_video"
  end

  def down
    add_index "requests", ["user_id", "youtube_id"], :name => "unique_user_and_video", :unique => true
  end
end
