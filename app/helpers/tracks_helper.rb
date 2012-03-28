module TracksHelper
  include YouTubeApi

  # create an object that can be passed to render :json
  def format_videos_json(response)
    response.videos.map do |video|
      format_video_json(video)
    end
  end

  def format_video_json(video)
    {}.tap do |hash|
      hash[:title] = video.title
      hash[:unique_id] = video.unique_id
      hash[:duration] = video.duration
    end
  end
end
