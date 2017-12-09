require 'aylien_text_api'
require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'json'

url = 'https://en.wikibooks.org/wiki/Category:Recipes'
agent = Mechanize.new
page = agent.get(url)
url = page.link_with(:text => 'next page').href
p url
=begin
client = AylienTextApi::Client.new(app_id: "9f52d7ca", app_key: "8e96ff5913abfce51ba5fcd3b5b56316")

summary = client.summarize(url: url, sentences_number: 3)

summary[:sentences].each do |sentence|
  puts sentence
end
=end
