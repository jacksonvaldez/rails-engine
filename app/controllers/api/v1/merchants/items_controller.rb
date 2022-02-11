class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    merchant = Merchant.where(id: params[:merchant_id]).first

    if merchant.class == Merchant
      items = Item.where(merchant_id: params[:merchant_id])
      render json: ItemSerializer.items_index(items)
    else
      render json: ErrorSerializer.return_error("invalid merchant id"), status: 404
    end
  end

end
