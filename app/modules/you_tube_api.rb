module YouTubeApi

  def self.included(base)
    base.class_eval do
      extend ClassMethods
    end
  end

  # methods defined on YouTubeApi, and also on
  # classes/modules that include YouTubeApi
  module ModuleAndInstanceMethods
    # perform the youtube video search by query term
    def find_matching_videos(query)
      client.videos_by(:query => query,         # search for the query
                       :categories => [:music], # it must be music
                       :format => 5)            # it must be embeddable
    end

    # find a video by id
    def find_video(id)
      client.video_by(id)
    end

    # reference to the youtube api client
    def client
      @youtube_api ||= YouTubeIt::Client.new(:dev_key => Rails.application.config.youtube_api_key)
    end
  end
  extend ModuleAndInstanceMethods
  include ModuleAndInstanceMethods

  # methods to be defined as class methods on including classes
  module ClassMethods

  end
end