require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

Dotenv.load('.env')


#definition de la méthode
def get_townhall_email(town_hall_url)

	page_1 = Nokogiri::HTML(open("#{town_hall_url}"))
	#("https://www.annuaire-des-mairies.com/95/avernes.html"))   
	#puts page.class   # => Nokogiri::HTML::Document
		
		#téléchargement de l'ensemble des symboles
	full_email_mairie = page_1.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')

	email_mairie = full_email_mairie.text
	return email_mairie

end


def get_url_data
 
	page_2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	#("https://www.annuaire-des-mairies.com/95/avernes.html"))   
	#puts page.class   # => Nokogiri::HTML::Document
		
		#téléchargement de l'ensemble des symboles
	half_url = page_2.xpath('//a[contains(@href, "./95/")]')

 end 




def get_townhall_urls(half_url)
	

	slice_url = half_url.map { |link| link['href'] }
	slice_url.each do |i|
		i.slice!(0) 
	end
	
	town_hall_url = slice_url.map { |j| "http://annuaire-des-mairies.com#{j}"}
	return town_hall_url

end


def city(half_url)
	
	town = half_url.map { |string| string.text  }
	#puts name_mairie

	return town

end



def mailing_list(town_hall_url,town)

	email_list = []

	town_hall_url.each do |i|
	email_mairie = get_townhall_email(i)
	email_list << email_mairie
	end

	annuaire = []
	town.each do |j|
	result = { j => email_list[town.index(j)]}
	annuaire << result
	
	end
	puts annuaire

end



def perform
	
	half_url = get_url_data

	town_hall_url = get_townhall_urls(half_url)

	town = city(half_url)


	annuaire = mailing_list(town_hall_url,town)


	

end


perform





#def perform
#	town_hall_url = get_townhall_urls
#	town_hall_url.each do |town_hall_url|	
#	get_townhall_email(town_hall_url)
#	end	
#end	


 #perform

#get_townhall_email("https://www.annuaire-des-mairies.com/95/saint-ouen-l-aumone.html")



# conservation du texte
#crypto_name_array = crypto_fullname_array.map { |string| string.text  }
	#puts crypto_name_array[0]

#Téléchargement de l'ensemble des prix
#crypto_fullprice_array = page.xpath('//*[@id]/td[5]/a')


# conservation des prix
#crypto_price_array = crypto_fullprice_array.map { |price| price.text}
	#puts crypto_price_array


# /html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]