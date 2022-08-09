require 'httparty'
require 'pry'
require './app/poros/holiday_search'

search = HolidaySearch.new

search.holiday_information.each do |holiday|
   puts holiday.name 
   puts holiday.date
   puts ""
end

