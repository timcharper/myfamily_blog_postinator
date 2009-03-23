class Adapter::Basic
  attr_reader :results
  
  def initialize(config)
    @config = config
    fetch
  end
  
  def fetch
    raise "implement me"
  end
  
  def last_post_datetime
    @results.first[:datetime]
  end
end