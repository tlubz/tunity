class Request < ActiveRecord::Base
  belongs_to :user

  # get the you tube video object associated with this request
  def video
    YouTubeApi.find_video(youtube_id)
  end

  # put the next video on the now playing list
  def self.play_next
    playing.update_all(:status => :done)
    next_request = self.next
    next_request.play!
  end

  # get the next n requests oldest first
  def self.next_requests(how_many = 20)
    not_done.oldest_first.limit(how_many)
  end

  # get the next request by time requested
  def self.next
    not_done.oldest_first.first
  end

  # get the position and current track as a SongPosition object
  # or nil if we are past the end of the current track
  def self.where?
    now = Time.now
    playing_request = playing.first
    if playing_request
      unless(now > playing_request.played_at + playing_request.video.duration)
        SongPosition.new(playing_request, (Time.now - playing_request.played_at).to_i)
      end
    end
  end

  # mark this as playing
  def play!
    update_attributes!(:status => :playing, :played_at => Time.now)
  end

  # mark this as finished
  def finish!
    update_attributes!(:status => :done)
  end

  def playing?
    status == 'playing'
  end

  def done?
    status == 'done'
  end

  def self.playing
    where(:status => :playing)
  end

  def self.done
    where(:status => :done)
  end

  def self.oldest_first
    order(:created_at)
  end

  def self.not_done
    where(:status => [:playing, nil])
  end

  class SongPosition < Struct.new(:request, :position); end
end
