require File.dirname(__FILE__) + '/config/environment.rb'

my_family = MyFamily.new(CONFIG['my_family'])

LAST_ARTCILES_FILENAME = CONFIGROOT + "/last_article_datetimes.yml"
last_article_datetimes = (YAML.load_file(LAST_ARTCILES_FILENAME) rescue {})

CONFIG['blogs'].keys.each do |blog_name|
  adapter = Adapter.for(blog_name)
  if last_article_datetimes[blog_name] != adapter.last_article_datetime
    last_article_datetimes[blog_name] ||= (adapter.last_article_datetime - 1.day) # prevent flood
    # new article
    adapter.articles.reverse.each do |article|
      next unless article[:datetime] > last_article_datetimes[blog_name]
      
      my_family.post_article(adapter.name, article)
      last_article_datetimes[blog_name] = article[:datetime]
      File.open(LAST_ARTCILES_FILENAME, "wb") { |f| f << last_article_datetimes.to_yaml }
    end
  end
end