require 'rails_helper'

RSpec.describe "discounts show page" do 
 it "has the bulk discount's quantity threshold and percentage discount" do 
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Walmart', status: 'Enabled')

    discount1 = merchant1.discounts.create!(percentage: 10, quantity_threshold: 20)
    discount2 = merchant1.discounts.create!(percentage: 40, quantity_threshold: 30)

    visit "/merchants/#{merchant1.id}/discounts/#{discount1.id}"

    expect(page).to have_content("Percentage: 10")
    expect(page).to have_content("Quantity threshold: 20")
    expect(page).to_not have_content("Percentage: 40")
    expect(page).to_not have_content("Quantity threshold: 40")
 end
end

#  As a merchant
# When I visit my bulk discount show page
# Then I see the bulk discount's quantity threshold and percentage discount