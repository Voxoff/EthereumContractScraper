require 'nokogiri'
require 'open-uri'
require 'pry-byebug'
require 'csv'

url="https://etherscan.io/txs?a=0xC3c94e2d9A33AB18D5578BD63DfdaA3e0EA74a49"

# page = Nokogiri::HTML(open(url))
# puts page.css("")
time = []
(1..56).each do |page_num|
  # binding.pry if page_num > 1
  url += "&p=#{page_num}" if page_num > 1
  doc = Nokogiri::HTML(open(url).read)
  doc.search('tr').each_with_index do |row, i|
    if i >= 1
      time << row.search('td')[2].text if row.search('td')[2]
    end
  end
  url = url.chomp("&p=#{page_num}") if page_num > 1
end


CSV.open("ethereumTimes.csv", "w") do |csv|
  csv << time
end
