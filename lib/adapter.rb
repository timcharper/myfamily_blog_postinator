class Adapter
  def self.for(name)
    config = CONFIG['blogs'][name]
    adapter = self.const_get(config['adapter'])
    adapter.new(name)
  end
end

require 'adapter/basic'
require 'adapter/blogger_private'
require 'adapter/rss'
