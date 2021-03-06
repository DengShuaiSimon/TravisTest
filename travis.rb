require 'rubygems'
#require 'nokogiri'
#require 'open-uri'
require 'json'
require 'net/http'
#require 'travis'
require 'find'

#repo =Travis::Repository.current
#puts repo
#ower_repo = system('echo $TRAVIS_REPO_SLUG')
ower_repo = ENV['TRAVIS_REPO_SLUG']
puts "ower_repo : #{ower_repo}"
#branch = system('echo $TRAVIS_BRANCH')
branch = ENV['TRAVIS_BRANCH']
puts "branch : #{branch}"
#event_type = system('echo $TRAVIS_EVENT_TYPE')
event_type = ENV['TRAVIS_EVENT_TYPE']
puts "event_type : #{event_type}"


#print all path at current path
puts "work path : #{Dir.pwd}"
Find.find('/home/travis/build/DengShuaiSimon/TravisTest') do |path| 
  puts path unless FileTest.directory?(path) 
end 

=begin
def get_all_file_full_path(home,result=nil)  
   result=[] unless result  
   Dir.entries(home).each do |sub|       
     unless  sub==".."   
       unless  sub=="."  
         #   puts "sub=#{sub} and #{sub==".." or sub=="."}"  
         if File.directory?("#{home}/#{sub}")  
           get_all_file_full_path("#{home}/#{sub}", result)  
         else  
           result<<"#{home}/#{sub}"  
         end    
       end          
     end  
   end    
   result  
 end  

=end

if(event_type == "pull_request")
  #pull_number = system('echo $TRAVIS_PULL_REQUEST')
  pull_number = ENV['TRAVIS_PULL_REQUEST']
  puts "pull_number : #{pull_number}"
  uri = "https://api.github.com/repos/#{ower_repo}/pulls/#{pull_number}"
  puts "pull_request_url : #{uri}"
  resp = Net::HTTP.get_response(URI.parse(uri))
  jresp = JSON.parse(resp.body)
  #puts "jresp: #{jresp}"
  title = jresp['title']
  puts "pull_request title : #{title}"
  body = jresp['body']
  puts "pull_request body : #{body}"
  
  # Remove digits
  #title = title.gsub!(/\D/, "")
  
  if(!(title =~ /^Add|Refine test case|cases for issue|feature(.*)/))
    raise "The title of this pull_request have a wrong format. Fix it!"
  end
  if(!(body =~ (/Add|Refine \d case|cases in this pull request(.*)/m))||!(body =~ (/This|These case|cases is|are added|refined for issue|feature(.*)/m))||!(body =~ (/This pull request is for task(.*)/m)))
    raise "The description of this pull_request have a wrong format. Fix it!"
  end
 
    
    
    
    
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
