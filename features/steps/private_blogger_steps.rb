
When /I allocate an adapter for happyharperz/ do
  @adapter = Adapter.for('happyharperz')
end

Then /it should return a list of posts with links, titles, dates and bodies/ do
  @adapter.results.should_not be_empty
  @adapter.results.first.keys.sort.should == [:datetime, :body, :link, :title].sort
end

Then /it should return the latest post/ do
  @adapter.last_post_datetime.should == @adapter.results.first[:datetime]
end