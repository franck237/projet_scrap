require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

Dotenv.load('.env')


#definition de la méthode
def get_deputy_email(deputy_url)

	page_1 = Nokogiri::HTML(open("#{deputy_url}"))
	#("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036"))   
	#puts page_1.class   # => Nokogiri::HTML::Document
		
		#téléchargement de l'email
	full_deputy_email = page_1.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a')

	deputy_email = full_deputy_email.text
	return deputy_email

end


def get_url_data
 
	page_2 = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
	#("https://www.annuaire-des-mairies.com/95/avernes.html"))   
	#puts page_2.class   # => Nokogiri::HTML::Document
		
		#téléchargement de l'ensemble des emails
	half_url = page_2.xpath('//a[contains(@href, "fiche")]')

 end 



def get_deputy_urls#(half_url)
	

page_2 = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
	#("https://www.annuaire-des-mairies.com/95/avernes.html"))   
	#puts page_2.class   # => Nokogiri::HTML::Document
		
		#téléchargement de l'ensemble des emails
	half_url = page_2.xpath('//a[contains(@href, "fiche")]')



	slice_url = half_url.map { |link| link['href'] }
	slice_url.each do |i|
		i.slice!(7) 
	end
	puts slice_url





	
	deputy_url = slice_url.map { |j| "http://www2.assemblee-nationale.fr/deputes#{j}"}
	return deputy_url

end

get_deputy_urls

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


#perform
