require File.dirname(__FILE__) + '/config/environment.rb'

my_family = MyFamily.new(CONFIG['my_family'])

LAST_POSTS_FILENAME = CONFIGROOT + "/last_post_datetimes.yml"
last_post_datetimes = (YAML.load_file(LAST_POSTS_FILENAME) rescue {})

CONFIG['blogs'].keys.each do |blog_name|
  adapter = Adapter.for(blog_name)
  if last_post_datetimes[blog_name] != adapter.last_post_datetime
    last_post_datetimes[blog_name] ||= (adapter.last_post_datetime - 1.day) # prevent flood
    # new post
    adapter.results.reverse.each do |post|
      next unless post[:datetime] > last_post_datetimes[blog_name]
      
      my_family.post_blog_entry(adapter.name, post)
      last_post_datetimes[blog_name] = post[:datetime]
      File.open(LAST_POSTS_FILENAME, "wb") { |f| f << last_post_datetimes.to_yaml }
    end
  end
end