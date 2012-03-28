require 'spec_helper'

describe Play do
  let(:now) { Time.now }
  let(:older) { Play.create!(:youtube_id => Sham.youtube_id, :created_at => now - 490.seconds) }
  let(:newer) { Play.create!(:youtube_id => Sham.youtube_id, :created_at => now) }
  describe '.current' do
    it 'should return the most recent play record' do
      first = older
      second = newer
      Play.current.should == first
    end
  end

  describe '.remove_current' do
    it 'should find the most recent record and remove it' do
      first = older
      second = newer
      Play.remove_current
      Play.where(:id => first.id).should be_empty
    end
  end
end
