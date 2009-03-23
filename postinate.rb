require File.dirname(__FILE__) + '/config/environment.rb'

last_post_datetimes = (YAML.load_file(CONFIGROOT + "/last_post_datetimes.yml") rescue {})

CONFIG['blogs'].keys.each do |blog_key|
  require 'ruby-debug'; Debugger.start; Debugger.start_control; debugger
  
  adapter = Adapter.for(blog_key)
  if last_post_datetimes[blog_key] != adapter.last_post_datetime
    last_post_datetimes[blog_key] ||= (adapter.last_post_datetime - 1.day) # prevent flood
    # new post
    adapter.results.each do |blogpost|
      next unless blogpost[:datetime] > last_post_datetimes[blog_key]
      puts "New post: #{blogpost[:title]}"
    end
  end
end