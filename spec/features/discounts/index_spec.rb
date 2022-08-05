require 'rails_helper' 

RSpec.describe "Discounts Index page" do 
  it "shows all discounts belonging to that merchant" do 
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Walmart', status: 'Enabled')

    discount1 = merchant1.discounts.create!(percentage: 10, quantity_threshold: 20)
    discount2 = merchant1.discounts.create!(percentage: 40, quantity_threshold: 30)

    visit "/merchants/#{merchant1.id}/discounts"

    expect(page).to have_content("Bulk Discounts")

    within "#discount-#{discount1.id}" do 
      expect(page).to have_content("#{discount1.percentage}")
      expect(page).to have_content("#{discount1.quantity_threshold}")
    end

    within "#discount-#{discount2.id}" do 
      expect(page).to have_content("#{discount2.percentage}")
      expect(page).to have_content("#{discount2.quantity_threshold}")
      expect(page).to_not have_content("#{discount1.quantity_threshold}")
    end
  end

  it "links to each discount's show page" do 
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Walmart', status: 'Enabled')

    discount1 = merchant1.discounts.create!(percentage: 10, quantity_threshold: 20)
    discount2 = merchant1.discounts.create!(percentage: 40, quantity_threshold: 30)

    visit "/merchants/#{merchant1.id}/discounts"

    click_link("my discount", match: :first)

    expect(current_path).to eq("/merchants/#{merchant1.id}/discounts/#{discount1.id}")
  end

  it "has a link to create a new discount" do 
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Walmart', status: 'Enabled')

    discount1 = merchant1.discounts.create!(percentage: 10, quantity_threshold: 20)
    discount2 = merchant1.discounts.create!(percentage: 40, quantity_threshold: 30)

    visit "/merchants/#{merchant1.id}/discounts"

    click_link("Create discount")

    fill_in('percentage', with: 20)
    fill_in('quantity_threshold', with: 40)

    click_button('Submit')

    expect(current_path).to eq("/merchants/#{merchant1.id}/discounts")
    expect(page).to have_content("Percentage: 20")
    expect(page).to have_content("Quantity threshold: 40")
  end
end
