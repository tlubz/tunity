class TracksController < ApplicationController
  include TracksHelper

  before_filter :authenticate_user!, :only => :add

  def index
  end

  def listen
    song_position = Request.where?
    if song_position
      redirect_to :action => :play,
                  :id => song_position.request.youtube_id,
                  :pos => song_position.position
    elsif Request.play_next
      redirect_to :action => :play,
                  :id => Request.playing.first.youtube_id,
                  :pos => 0
    else
      render 'tracks/listen/no_requests'
    end
  end

  def play
    js_page_vars[:youtube_id] = params[:id]
    js_page_vars[:pos] = params[:pos].to_i
  end

  def add
    Request.create!(:user => current_user, :youtube_id => params[:id])
    flash[:notice] = "Added #{find_video(params[:id]).title} to the playlist"
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
