class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = Merchant.all
    render json: MerchantSerializer.merchants_index(merchants)
  end

  def show
    merchant = Merchant.where(id: params[:id]).first

    if merchant.class == Merchant
      render json: MerchantSerializer.merchants_show(merchant)
    else
      render json: Serializer.return_errors(["invalid merchant id"]), status: 404
    end
  end

end
