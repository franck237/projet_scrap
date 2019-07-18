require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

Dotenv.load('.env')

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   
#puts page.class   # => Nokogiri::HTML::Document


#téléchargement de l'ensemble des symboles
crypto_fullname_array = page.xpath('//*[@id]/td[3]')


# conservation du texte
crypto_name_array = crypto_fullname_array.map { |string| string.text  }
	#puts crypto_name_array[0]

#Téléchargement de l'ensemble des prix
crypto_fullprice_array = page.xpath('//*[@id]/td[5]/a')


# conservation des prix
crypto_price_array = crypto_fullprice_array.map { |price| price.text}
	#puts crypto_price_array


# Pour convertir en float
#crypto_price_array.collect do |value| 
 # value.to_f 
#end
#puts crypto_price_array[0].class



#Création de l'array final (contenant les hashes)
crypto_array = []

crypto_name_array.each do |symbol|

result = { symbol => crypto_price_array[crypto_name_array.index(symbol)] }
    crypto_array << result

  end

  puts crypto_array#[0]