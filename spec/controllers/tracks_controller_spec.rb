require 'spec_helper'

describe TracksController do
  describe 'GET search' do
    it 'calls find_matching_videos and renders json' do
      query = 'something'
      response = {:something => :yo}
      parsed_response = {:norb => :doh}
      stub(controller).find_matching_videos(query) { response }
      mock(controller).format_videos_json(controller.find_matching_videos(query)) { parsed_response }
      mock(controller).render # allow the call to render anyway
      mock(controller).render(:json => parsed_response)

      get :search, :query => query

    end
  end
end
