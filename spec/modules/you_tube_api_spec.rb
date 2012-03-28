require 'spec_helper'

describe YouTubeApi do
  describe '#find_matching_videos' do
    let(:query) { 'halcyon pastures' }
    let(:response) do
      YouTubeIt::Response::VideoSearch.new(
        :videos => [YouTubeIt::Model::Video.new(:title => 'Halcyon - Pastures')])
    end

    it 'should hit the youtube search api and return the result' do
      mock(YouTubeApi.client).videos_by.with_any_args { response }
      YouTubeApi.find_matching_videos(query).should == response
    end
  end

  describe '#find_video' do
    let(:id) { "IDm6Sdf9_Uw" }
    let(:video) { YouTubeIt::Model::Video.new(:title => 'Halcyon - Pastures') }

    it 'should hit the youtube find api and return the video by id' do
      mock(YouTubeApi.client).video_by(id) { video }
      YouTubeApi.find_video(id).should == video
    end
  end
end