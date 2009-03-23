class Adapter::Basic
  attr_reader :results, :name
  
  def initialize(name)
    @config = CONFIG['blogs'][name]
    @name = name
    fetch
  end
  
  def fetch
    raise "implement me"
  end
  
  def last_post_datetime
    @results.first[:datetime]
  end
end