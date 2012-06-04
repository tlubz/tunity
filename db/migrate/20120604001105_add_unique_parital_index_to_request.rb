class AddUniqueParitalIndexToRequest < ActiveRecord::Migration
  def up
    execute 'CREATE UNIQUE INDEX request_user_youtube_unique_where_not_done ON requests (user_id, youtube_id) WHERE status != \'done\' OR status IS NULL'
  end

  def down
    execute 'DROP INDEX request_user_youtube_unique_where_not_done'
  end
end
