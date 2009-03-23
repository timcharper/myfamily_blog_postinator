class MyFamily
  include WebSickle
  include WebSickle::Helpers::AspNet
  URL = "http://www.myfamily.com/isapi.dll?c=site&htx=Main&siteid=*"
  
  def initialize(config)
  end
  
  def new_mechanize_agent
    a = super
    a.follow_meta_refresh = true
    a
  end
  
  def follow_js_redirect
    if (js = (@page.parser / "script").inner_text) && (js.match /window.location *= *["''](.+)["'']/)
      url = $1
      open_page(url)
    end
  end
  
  def navigate_to_add_news
    if @add_news_page
      set_page(@add_news_page)
    else
      login
      set_page(@home_page)
      click_link(:href => /htx=Edit.+contentclass=NEWS/)
      @add_news_page = @page
    end
  end
  
  def login
    @logged_in ||= (
      open_page(URL)
      submit_form(
        :identified_by => {:name => 'loginform'},
        :values => {
          'username' => CONFIG["my_family"]['login'],
          'password' => CONFIG["my_family"]['password']
        },
        :submit => {"value" => "Login"}
      )
      follow_js_redirect
      @home_page = @page
      true
    )
  end
  
  def post_blog_entry(blog_name, blog_entry)
    navigate_to_add_news
    
    select_form(:name => 'EditContent')
    set_form_values(
      'Title' => "#{blog_name}: #{blog_entry[:title]}",
      'DescriptionMIMEType' => true,
      'Description' => "#{blog_entry[:body]}\n\n<p><a href='#{blog_entry[:link]}'>Click here for the original posting</p>",
      'NewCat' => 'BLOG'
    )
    submit_form_button(:name => 'Save')
  end
end