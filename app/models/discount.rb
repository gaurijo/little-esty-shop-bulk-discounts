class Discount < ApplicationRecord 
  validates_presence_of :percentage, :quantity_threshold
  validates_numericality_of :percentage 

  belongs_to :merchant 
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items 
  has_many :invoices, through: :invoice_items 
  has_many :transactions, through: :invoices 
  has_many :customers, through: :invoices 
end