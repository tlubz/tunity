require 'spec_helper'

describe Request do
  it 'should not allow multiple requests for the same song per user' do
    user = User.make
    id = Sham.youtube_id
    Request.make(:user => user, :youtube_id => id)
    ->{ Request.make(:user => user, :youtube_id => id) }.should raise_error
    Request.make(:user => User.make, :youtube_id => id)
  end

  it 'should allow new requests for the same song if all other requests have been played' do
    user = User.make
    id = Sham.youtube_id
    Request.make(:user => user, :youtube_id => id, :status => :done)
    Request.make(:user => user, :youtube_id => id)
  end

  describe '.play_next' do
    before do
      now = Time.now
      @first_request = Request.make(:created_at => now - 1)
      Request.make(:created_at => now)
    end

    it 'should mark the record as playing' do
      next_request = Request.next
      Request.play_next
      next_request.reload
      next_request.should be_playing
    end

    it 'should set played_at to now' do
      now = Time.now
      stub(Time).now { now }
      next_request = Request.next
      Request.play_next
      next_request.reload
      next_request.played_at.to_i.should == now.to_i
    end

    it 'should mark any playing requests as done' do
      playing_request = Request.make.tap{ |r| r.play! }
      Request.play_next
      playing_request.reload
      playing_request.should_not be_playing
      playing_request.should be_done
    end
  end

  describe '.next' do
    it 'should return the next record by play time' do
      now = Time.now
      first_request = Request.make(:created_at => now - 1)
      Request.make(:created_at => now)
      Request.next.should == first_request
    end
  end

  describe '.next_requests' do
    it 'should return the next few requests' do
      now = Time.now
      requests = 0.upto(2).map do |n|
        Request.make(:created_at => now - 2 + n)
      end
      Request.next_requests.should == requests
    end
  end

  describe '#video' do
    it 'should get the youtube video associated with the youtube id' do
      r = Request.make
      vid = YouTubeIt::Model::Video.new({})
      stub(YouTubeApi).find_video(r.youtube_id) { vid }
      r.video.should == vid
    end
  end

  describe '.where?' do
    it 'should return whatever the currently playing track is, and the position in the track' do
      now = Time.now
      position = 50.seconds
      Request.make(:created_at => now)
      r = Request.make(:status => :playing, :created_at => now - 100, :played_at => now - position)
      stub(YouTubeApi).find_video.stub!.duration { 200.seconds }

      Request.where?.request.should == r
      Request.where?.position.should == position
    end

    it 'should return nil if there is no currently playing track or if it is finished' do
      now = Time.now
      position = 500.seconds
      duration = 300.seconds
      request = Request.make(:played_at => now - position)
      stub(request).video.stub!.duration { duration }
      stub(Request).playing.stub!.first { request }

      Request.where?.should be_nil
    end

    it 'should return nil if there are no more tracks to play' do
      Request.where?.should be_nil
    end
  end
end
