class AddPlayedAtToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :played_at, :timestamp
  end
end
