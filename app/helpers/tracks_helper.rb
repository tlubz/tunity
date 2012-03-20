module TracksHelper
  # perform the youtube video search by query term
  def find_matching_videos(query)
    youtube_api.videos_by(:query => query)
  end

  # create an object that can be passed to render :json
  def format_videos_json(response)
    response.videos.map do |video|
      {}.tap do |hash|
        hash[:title] = video.title
        hash[:unique_id] = video.unique_id
        hash[:duration] = video.duration
      end
    end
  end

  # reference to the youtube api client
  def youtube_api
    @youtube_api ||= YouTubeIt::Client.new(:dev_key => Rails.application.config.youtube_api_key)
  end
end
