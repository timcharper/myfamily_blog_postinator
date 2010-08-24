require 'simple-rss'
require 'open-uri'

class Adapter::RSS < Adapter::Basic
  def initialize(name)
    super
  end
  
  def eval_entities(content)
    content = content.to_s.dup
    content.gsub!('&lt;', '<')
    content.gsub!('&gt;', '>')
    content.gsub!('&amp;', '&')
    content
  end
  
  def fetch
    content = open(@config['url'])
    rss = SimpleRSS.parse(content)
    rss.items.map do |article|
      {
        :datetime => article.pubDate || article.published,
        :body => article.content_encoded || eval_entities(article.content || article.description).to_s,
        :link => article.link,
        :title => article.title
      }
    end
  end
end