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
end
