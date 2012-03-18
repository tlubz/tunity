require 'spec_helper'

describe TracksController do
  describe 'GET search' do
    it 'calls find_matching_videos and renders json' do
      query = 'something'
      response = {:something => :yo}
      mock(controller).find_matching_video(query) { response }
      mock(controller).respond(:json => response)

      get :search, :query => query

    end
  end
end
