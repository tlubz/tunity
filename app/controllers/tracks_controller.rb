class TracksController < ApplicationController
  include TracksHelper

  before_filter :authenticate_user!, :only => :add

  def index
  end

  def add
    Request.create!(:user => current_user, :youtube_id => params[:id])
    flash[:notice] = "Added #{find_video(params[:id]).title} to the vine"
    redirect_to :controller => :home, :action => :index
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
