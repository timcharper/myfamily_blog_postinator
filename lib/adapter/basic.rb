class Adapter::Basic
  attr_reader :name
  
  def initialize(name)
    @config = CONFIG['blogs'][name]
    @name = name
  end
  
  def fetch
    raise "implement me"
  end
  
  def last_article_datetime
    articles.first[:datetime]
  end
  
  def articles
    @articles ||= fetch
  end
end