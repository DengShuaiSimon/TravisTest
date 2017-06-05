require 'rubygems'
#require 'nokogiri'
#require 'open-uri'
require 'json'
require 'net/http'
#require 'travis'

#repo =Travis::Repository.current
#puts repo
#ower_repo = system('echo $TRAVIS_REPO_SLUG')
ower_repo = ENV['TRAVIS_REPO_SLUG']
puts ower_repo
#branch = system('echo $TRAVIS_BRANCH')
branch = ENV['TRAVIS_BRANCH']
puts branch
#event_type = system('echo $TRAVIS_EVENT_TYPE')
event_type = ENV['TRAVIS_EVENT_TYPE']
puts event_type


if(event_type == "pull_request")
  #pull_number = system('echo $TRAVIS_PULL_REQUEST')
  pull_number = ENV['TRAVIS_PULL_REQUEST']
  puts pull_number
  uri = "https://api.github.com/repos/#{ower_repo}/pulls/#{pull_number}"
  puts uri
  resp = Net::HTTP.get_response(URI.parse(uri))
  jresp = JSON.parse(resp.body)
  #puts "jresp: #{jresp}"
  title = jresp['title']
  puts "title : #{title}"
  body = jresp['body']
  puts "body : #{body}"
  
  
  #post_url = "https://api.github.com/repos/#{ower_repo}/issues/#{pull_number}/comments"
  #puts post_url
  #system('curl -H "Authorization: token 247bbee4e75c21b55f272aa64a89aa804efd9126" https://api.github.com')
  #system('curl -u "DengShuaiSimon" https://api.github.com')
  #post_uri = URI.parse(post_url)
  #params = {} 
  #params["body"] = 'successful'
  #res = Net::HTTP.post_form(post_uri, params)  
  #puts res.header['set-cookie'] 
  #puts res.body
  
end

