require './app/poros/holiday'
require './app/services/holiday_service'

class HolidaySearch
   def holiday_information 
      service.holidays.slice(8..10).map do |data| #ideally would've used a helper method to test against the holiday dates
         Holiday.new(data)
      end
   end

   def service 
      HolidayService.new 
   end
end