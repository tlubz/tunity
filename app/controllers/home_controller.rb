class HomeController < ApplicationController
  include TracksHelper
  def index
    @track_list = Request.next_requests.map do |request|
      {
        :video => request.video,
        :user => request.user,
        :status => request.status,
      }
    end
  end

end
