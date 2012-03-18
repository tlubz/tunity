module TracksHelper
  def find_matching_videos(query)
    youtube_api.videos_by(:query => query)
  end

  def youtube_api
    @youtube_api ||= YouTubeIt::Client.new(:dev_key => Rails.application.config.youtube_api_key)
  end
end
