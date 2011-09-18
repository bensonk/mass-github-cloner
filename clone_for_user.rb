#!/usr/bin/env ruby
require 'uri'
require 'json'
require 'net/http'
require 'github'

def clone_repos_for user
  data = Net::HTTP.get URI.parse("http://github.com/api/v2/json/repos/show/#{user}")
  repos = JSON.parse(data)['repositories']
  repos.each do |r|
    system "gh clone %s/%s" % [ r['owner'], r['name'] ]
  end
end

ARGV.each do |user|
  clone_repos_for user
end
