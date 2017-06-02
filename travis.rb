require 'rubygems'
#require 'nokogiri'
#require 'open-uri'
require 'json'
require 'net/http'

#uri = "https://api.github.com/repos/DengShuaiSimon/xcat-core/pulls"
uri = "https://api.github.com/repos/DengShuaiSimon/xcat-core/events"
resp = Net::HTTP.get_response(URI.parse(uri))

jresp = JSON.parse(resp.body)
json = jresp[0]

#puts jresp['title']
puts "event type : #{json['type']}"
puts "repo name : #{json['repo']['name']}"
puts "repo url : #{jresp[0]['repo']['url']}"

if(json['type']=="PushEvent")
  puts "payload/commits : #{json['payload']['commits']}"
elsif(json['type']=="PullRequestEvent")
  puts "pull_request title : #{json['payload']['pull_request']['title']}"
  puts "pull_request description : #{json['payload']['pull_request']['body']}"
elsif(json['type']=="IssueCommentEvent")
  puts "issue title : #{json['payload']['issue']['title']}"
  puts "comment body : #{json['payload']['comment']['body']}"
end

#puts "repo url : #{jresp[0]['repo']['url']}"
