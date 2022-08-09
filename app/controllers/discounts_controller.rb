class DiscountsController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidaySearch.new
  end

  def show 
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.create!(discount_params)

    redirect_to "/merchants/#{@merchant.id}/discounts"
  end

  def destroy 
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to "/merchants/#{merchant.id}/discounts"
  end

  def edit 
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update 
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
    @discount.update(discount_params)
    redirect_to "/merchants/#{@merchant.id}/discounts/#{@discount.id}"
  end
  
  private 
  
  def discount_params 
    params.permit(:percentage, :quantity_threshold)
  end
end