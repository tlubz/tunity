class Request < ActiveRecord::Base
  belongs_to :user

  # get the youtube id of the next most requested song
  # if there are multiple songs equally most requested, then return
  # the earliest requested song
  def self.next_youtube_id
    youtube_ids_and_counts = self.youtube_ids_and_counts
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

  # put the next video on the now playing list
  def self.play_next
    play_video(next_youtube_id)
  end

  # put a video on the now-playing list
  def self.play_video(youtube_id)
    where(:youtube_id => youtube_id).delete_all
    Play.create!(:youtube_id => youtube_id)
  end

  # get the next few requests, in order of request counts
  # in order of time requested, uniqued by youtube id
  def self.get_next(num = 25)
    youtube_ids_and_counts = self.youtube_ids_and_counts
    youtube_ids_and_counts.group_by{|youtube_id, count| count}.map do |count, group_youtube_ids_and_counts|
      Request.where(:youtube_id => group_youtube_ids_and_counts.map{|youtube_id, count| youtube_id}).
          order(:created_at).uniq_by(&:youtube_id)
    end.flatten
  end

  private

    def self.youtube_ids_and_counts
      group(:youtube_id).order("count_all desc").count.to_a
    end
end
