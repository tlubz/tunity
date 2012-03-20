require 'spec_helper'
describe TracksHelper do
  describe '#find_matching_videos' do
    let(:query) { 'halcyon pastures' }
    let(:response) do
      YouTubeIt::Response::VideoSearch.new(
        :videos => [YouTubeIt::Model::Video.new(:title => 'Halcyon - Pastures')])
    end

    it 'hits the youtube api and returns the result' do
      mock(helper.youtube_api).videos_by(:query => query) { response }

      helper.find_matching_videos(query).should == response
    end
  end

  describe '#format_videos_json' do
    let(:video_params) { {:title => 'Halcyon - Pastures', :unique_id => "IDm6Sdf9_Uw", :duration => 395} }
    let(:response) do
      YouTubeIt::Response::VideoSearch.new(
        :videos => [YouTubeIt::Model::Video.new(video_params)])
    end
    let(:parsed_response) { video_params }
    
    it 'should return a hash of the video parameters we care about' do
      helper.format_videos_json(response).should == [parsed_response]
    end

    
  end
end
