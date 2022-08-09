class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants 

  enum status: { 'in progress' => 0, 'cancelled' => 1, 'completed' => 2 }

  def total_rev
    invoice_items.sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def discounted_revenue
    x = invoice_items
    .joins(:discounts) #join invoice on discounts
    .where('invoice_items.quantity >= discounts.quantity_threshold') 
    #must meet this condition ^ invoice items qty >= discounts qty threshold
    .select('invoice_items.id, max((discounts.percentage) * (invoice_items.quantity * invoice_items.unit_price)) AS disc').group('invoice_items.id')
    #of those that meet the condition, i'm SELECTing the invoice_item id of the invoice_item totals and
    #applying the MAXIMUM discount % to that total (giving it alias called 'disc')
    #i'm grouping that 'disc' by the invoice_items id (part of our select statement)
    .sum(&:disc)/100
    #taking the sum of several discount elements so we need to map over the discounts and sum that total
    #if i try to take sum without using the mapping of elements i get error saying 'disc' column doesn't exist
    #div by 100 bc percentage
    total_rev - x 
    #subtract entire thing (x) from our total_rev method above to get the discounted revenue 
  end



#i want the invoice_items where the discount threshold is equal/less than invoice item qty 
#the highest discount available is applied to the invoice for the items_qty that's within the threshold.
#   merchant 1 has 1 discount 20% off 10 items
#   invoice_item 1 qty on Invoice 1 is 10
#   invoice_item 2 qty on Invoice 1 is 5
#   ONLY invoice_item 1 should receive the 20% discount, not invoice_item 2
#the discounted revenue is the total revenue minus whatever you get for the applied discount
#total_rev - x == discounted_revenue

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not(invoice_items:{status: 2})
    .order(created_at: :desc).distinct
  end
end
