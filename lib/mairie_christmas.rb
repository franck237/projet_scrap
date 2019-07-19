require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

Dotenv.load('.env')



def get_townhall_email(town_hall_url)

	page_1 = Nokogiri::HTML(open("#{town_hall_url}"))

	full_email_mairie = page_1.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')

	email_mairie = full_email_mairie.text
	return email_mairie

end


def get_url_data
 
	page_2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

		
	
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
	

end



def perform
	
	half_url = get_url_data

	town_hall_url = get_townhall_urls(half_url)

	town = city(half_url)


	annuaire = mailing_list(town_hall_url,town)

	
	return annuaire

end


perform

