# initializer for redis
module Tunity
  # get redis instance
  def self.redis
    @redis ||= _redis
  end

  protected

  # create the redis instance
  def self._redis
    opts = {} # put any global conf options here
    if url_string = ENV['REDISTOGO_URL']
      uri = URI.parse(url_string)
      opts[:host] = uri.host
      opts[:port] = uri.port
      opts[:password] = uri.password
      opts[:timeout] = 1 # one second
    end
    Redis.new(opts)
  end
end
