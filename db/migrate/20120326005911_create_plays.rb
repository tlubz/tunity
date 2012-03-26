class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.string :youtube_id

      t.timestamps
    end
  end
end
