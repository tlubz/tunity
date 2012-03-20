class TracksController < ApplicationController
  include TracksHelper
  def search
    render :json => format_videos_json(find_matching_videos(params[:query]))
  end
end
