class TracksController < ApplicationController
  include TracksHelper

  before_filter :authenticate_user!, :only => :add

  def index
  end

  def add

  end

  def search
    respond_to do |format|
      format.json { render :json => format_videos_json(find_matching_videos(params[:query])) }
      format.html do
        @videos = format_videos_json(find_matching_videos(params[:query]))
        @query = params[:query]
      end
    end
  end
end
