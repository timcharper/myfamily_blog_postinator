class Adapter::BloggerPrivate < Adapter::Basic
  attr_reader :logged_in
  
  def initialize(name)
    super
  end
  
  def selectors
    @config['selectors']
  end
  
  def fetch
    @config['url']
    login
    
    datetimes = 
      case
      when selectors["date"] && selectors["time"]
        dates = (@blog_page.parser / selectors["date"]).map {|n| n.inner_text }
        times = (@blog_page.parser / selectors["time"]).map {|n| n.inner_text }
        dates.zip(times).map { |d,t| Time.parse("#{d} #{t}") }
      else
        raise ArgumentError, "not implemented"
      end
    
    titles = (@blog_page.parser / selectors["title"]).map { |n| n.inner_text }
    links = (@blog_page.parser / selectors["link"]).map { |n| n.attributes['href'].to_s }
    bodies = (@blog_page.parser / selectors["body"]).map { |n| n.inner_html }
    
    datetimes.zip(titles, links, bodies).map do |datetime, title, link, body|
      {
        :datetime => datetime,
        :body => body,
        :link => link,
        :title => title
      }
    end
  end
end