class HomeController < ApplicationController
  include TracksHelper
  def index
    @track_list = Request.get_next.map do |request|
      {
          :video => YouTubeApi.find_video(request.youtube_id),
          :user => request.user
      }
    end
  end

end
