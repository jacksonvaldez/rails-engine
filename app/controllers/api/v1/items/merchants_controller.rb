class Api::V1::Items::MerchantsController < ApplicationController

  def show
    item = Item.where(id: params[:item_id]).first

    if item.class == Item
      merchant = Merchant.where(id: item.merchant_id).first
      render json: MerchantSerializer.merchants_show(merchant)
    else
      render json: Serializer.return_errors(["invalid item id"]), status: 404
    end
  end

end
