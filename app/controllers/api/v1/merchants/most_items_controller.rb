class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    if params[:quantity].present? && params[:quantity].to_i > 0
      merchants = Merchant.with_most_items(params[:quantity].to_i)
      render json: MostItemsSerializer.merchants_index(merchants)
    elsif params[:quantity].nil?
      merchants = Merchant.with_most_items(5)
      render json: MostItemsSerializer.merchants_index(merchants)
    else
      binding.pry
      render json: ErrorSerializer.return_error("quantity is either invalid or less than 1")
    end
  end

end
