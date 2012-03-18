class TracksController < ApplicationController
  include TracksHelper
  def search
    render :json => find_matching_videos(params[:query])
  end
end
