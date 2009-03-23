class Adapter
  def self.for(config_key)
    config = CONFIG['blogs'][config_key]
    adapter = self.const_get(config['adapter'])
    adapter.new(config)
  end
end

require 'adapter/basic'
require 'adapter/blogger_private'
require 'adapter/rss'
