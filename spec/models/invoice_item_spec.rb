require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of :unit_price}
    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values('pending' => 0, 'packaged' => 1, 'shipped' => 2) }
  end

  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
    it { should have_many(:merchants).through(:item) }
    it { should have_many(:discounts).through(:merchants) }
    it { should have_many(:customers).through(:merchants) }
    it { should have_many(:transactions).through(:invoice) }
  end
end
