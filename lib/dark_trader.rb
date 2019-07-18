require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

Dotenv.load('.env')

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   
puts page.class   # => Nokogiri::HTML::Document

crypto_fullname_array = page.xpath('//*[@id]/td[3]')

crypto_name_array = crypto_fullname_array.map { |string| string.text  }
	#puts crypto_name_array[0]

crypto_fullprice_array = page.xpath('//*[@id]/td[5]')

crypto_price_array = crypto_fullprice_array.map { |price| price.text  }
	puts crypto_price_array



#XPath Symbol Bitcooin
#//*[@id="id-bitcoin"]/td[3]

#XPath Symbol EOS
#//*[@id="id-eos"]/td[3]

#XPath Prix EOS
#//*[@id="id-eos"]/td[5]/a