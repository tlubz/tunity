class Request < ActiveRecord::Base
  belongs_to :user

  # get the youtube id of the next most requested song
  # if there are multiple songs equally most requested, then return
  # the earliest requested song
  def self.next_youtube_id
    youtube_ids_and_counts = group(:youtube_id).order("count_all desc").count.to_a
    highest_count = youtube_ids_and_counts[0][1]
    youtube_ids_and_counts = youtube_ids_and_counts.take_while do |youtube_id, count|
      count == highest_count
    end
    # if there is only one, return it
    if youtube_ids_and_counts.count == 1
      youtube_ids_and_counts[0][0]
    else
      # otherwise return the first requested
      Request.where(:youtube_id => youtube_ids_and_counts.map{|youtube_id, count| youtube_id}).
          order(:created_at).first.youtube_id
    end
  end
end
