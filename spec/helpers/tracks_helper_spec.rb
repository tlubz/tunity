require 'spec_helper'
describe TracksHelper do
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
