require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

Dotenv.load('.env')

def get_data

	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   
	#puts page.class   # => Nokogiri::HTML::Document

end


def extraction_symbol(page)
		
	#téléchargement de l'ensemble des symboles
	crypto_fullname_array = page.xpath('//*[@id]/td[3]')


	# conservation du texte
	crypto_name_array = crypto_fullname_array.map { |string| string.text  }
		#puts crypto_name_array[0]

	return crypto_name_array

end

def extraction_price(page)
	

	#Téléchargement de l'ensemble des prix
	crypto_fullprice_array = page.xpath('//*[@id]/td[5]/a')


	# conservation des prix
	crypto_price_array = crypto_fullprice_array.map { |price| price.text  }
		#puts crypto_price_array

	return crypto_price_array

end



def crypto(crypto_name_array, crypto_price_array)

	#Création de l'array final (contenant les hashes)
	crypto_array = []

	crypto_name_array.each do |symbol|

	result = { symbol => crypto_price_array[crypto_name_array.index(symbol)] }
	    crypto_array << result

	 end
	  puts crypto_array

end



def perform

	page = get_data
	crypto_name_array = extraction_symbol(page)
	crypto_price_array = extraction_price(page)
	extraction_price(page)
	extraction_symbol(page)
	crypto(crypto_name_array,crypto_price_array)
	


end

perform


