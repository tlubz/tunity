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
end
