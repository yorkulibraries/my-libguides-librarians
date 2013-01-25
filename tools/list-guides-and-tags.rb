#!/usr/bin/env ruby

# Produces a tab-separated list of LibGuides guides and their tags, e.g:
#
# Business	
# Business Ethics	s:sb/*
# Canadiana	s:ak/cdns,s:ap/cdns,s:as/cdns,s:gl/cdns

require 'open-uri'
require 'rubygems'
require 'nokogiri'

iid = 1669

# Restrict to a group of guides
#guides_url = "http://api.libguides.com/api_search.php?iid=#{iid}&type=group&search=Subject%20Research%20Guides&more=false&target=_self&break=li&context=object&format=json"

# Get all guides as a <ul> ... </ul>
guides_url = "http://api.libguides.com/api_search.php?iid=#{iid}&more=false&target=_self&break=li&context=object&format=json"

guides = Nokogiri::HTML(open(guides_url))

# Run through each <li> in the list
guides.xpath("//li").each do |l|
  # Pick out the URL ...
  url = l.css("a").attribute("href")
  title = l.css("a").text
  print "#{title}\t"
  # ... then download it and parse it ...
  guide_html = Nokogiri::HTML(open(url))
  #  ... thankfully, we can depend on a reliable HTML structure (I hope),
  # and the tags will always be listed in the same place.
  guide_html.xpath("//span[@class='guidetags']").each do |s|
    # s.xpath("a").each do |a|
    print s.xpath("a").map {|x| x.text}.join(",")
  end
  print "\n"
end

