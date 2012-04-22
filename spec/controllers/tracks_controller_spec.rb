require 'spec_helper'

describe TracksController do
  include Devise::TestHelpers

  describe 'GET search' do
    let(:query) { 'something' }
    let(:response) { {:something => :yo} }
    let(:parsed_response) { {:norb => :doh} }

    before do
      stub(controller).find_matching_videos(query) { response }
      stub(controller).format_videos_json(controller.find_matching_videos(query)) { parsed_response }
    end

    it 'calls find_matching_videos' do
      mock(controller).find_matching_videos(query) { response }
      get :search, :query => query
    end

    it 'renders a search / results page' do
      mock(controller).render
      get :search, :query => query
    end

    it 'renders json when format is json' do
      mock(controller).format_videos_json(controller.find_matching_videos(query)) { parsed_response }
      mock(controller).render # allow the call to render anyway
      mock(controller).render(:json => parsed_response)
      get :search, :query => query, :format => :json
    end
  end

  describe 'GET add' do
    let(:id) { Sham.youtube_id }
    let(:title) { Sham.song_title }
    let(:user) { User.make }

    before do
      stub(controller).find_video(id) { YouTubeIt::Model::Video.new(:title => title) }
      sign_in(user)
    end

    it 'sets a flash message' do
      get :add, :id => id
      controller.flash[:notice].should include title
    end

    it 'adds the video to the channel' do
      get :add, :id => id
      Request.where(:youtube_id => id, :user_id => user.id).should be_present
    end
  end

  describe 'GET play' do
    let(:id) { Sham.youtube_id }
    let(:pos) { 50 }

    it 'sets youtube id as javascript var' do
      get :play, :id => id
      controller.js_page_vars[:youtube_id].should == id
    end

    it 'sets the pos as a js var' do
      get :play, :id => id, :pos => pos
      controller.js_page_vars[:pos].should == pos
    end
  end

  describe 'GET listen' do
    it 'should redirect to play the current song position' do
      playing_request = Request.make
      position = 50
      stub(Request).where? { Request::SongPosition.new(playing_request, position) }
      mock.proxy(controller).redirect_to(:action => :play, :id => playing_request.youtube_id, :pos => position)
      get :listen
    end

    it 'should play the next song if the current song is done' do
      next_request = Request.make
      stub(Request).where? { nil }
      stub(Request).playing { [next_request] }
      stub(Request).play_next
      mock.proxy(controller).redirect_to(:action => :play, :id => next_request.youtube_id, :pos => 0)
      get :listen
    end

    it 'should render a no song message if there are no more' do
      stub(Request).where? { nil }
      stub(Request).playing.stub!.update_all
      get :listen
    end
  end
end
