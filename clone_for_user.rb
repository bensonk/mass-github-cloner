#!/usr/bin/env ruby
require 'uri'
require 'json'
require 'net/http'
require 'github'

def clone_repos_for user
  data = Net::HTTP.get URI.parse("http://github.com/api/v2/json/repos/show/#{user}")
  repos = JSON.parse(data)['repositories']
  if repos
    repos.each do |r|
      system "gh clone %s/%s" % [ r['owner'], r['name'] ]
    end
    "Successfully cloned #{user}'s repositories."
  else
    "Either #{user} does not exist or they have no repositories."
  end
end

ARGV.each do |user|
  puts clone_repos_for user
end
