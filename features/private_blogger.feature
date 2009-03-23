Feature: List posts from a private blog

  In order to relay blog posts
  As an system
  I want log in and view posts in a private blog
  
  Scenario: Log in to happyharperz
    When I allocate an adapter for happyharperz
    Then it should return a list of posts with links, titles, dates and bodies