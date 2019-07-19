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
	return half_url

 end 



def get_deputy_urls(half_url)
	

#page_2 = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
	#("https://www.annuaire-des-mairies.com/95/avernes.html"))   
	#puts page_2.class   # => Nokogiri::HTML::Document
		
		#téléchargement de l'ensemble des emails
	#half_url = page_2.xpath('//a[contains(@href, "fiche")]')



	slice_url = half_url.map { |link| link['href'] }
	

	deputy_url = slice_url.map { |j| "http://www2.assemblee-nationale.fr#{j}"}
	
	return deputy_url
end


def entire_name(half_url)

	#page_2 = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
	#("https://www.annuaire-des-mairies.com/95/avernes.html"))   
	#puts page_2.class   # => Nokogiri::HTML::Document
		
		#téléchargement de l'ensemble des emails
	#half_url = page_2.xpath('//a[contains(@href, "fiche")]')

	
	all_name = half_url.map { |string| string.text  }
	#puts name_mairie

	return all_name

end


def mailing_list(deputy_url,all_name)

	email_list = []

	deputy_url.each do |i|
	deputy_email = get_deputy_email(i)
	email_list << deputy_email
	end

	annuaire = []
	all_name.each do |j|
	result = { j => email_list[all_name.index(j)]}
	annuaire << result
	
	end


end



def perform
	
	half_url = get_url_data

	deputy_url = get_deputy_urls(half_url)

	all_name = entire_name(half_url)

	annuaire = mailing_list(deputy_url,all_name)	
	puts annuaire

end


#perform
