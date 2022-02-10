class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.search_by_name(params[:name].to_s).first

    if params[:name].present? && params[:name] != ""
      if merchant.class == Merchant
        render json: MerchantSerializer.merchants_show(merchant)
      else
        render json: Serializer.no_record_found
      end
    else
      render json: Serializer.return_error("name query is either missing or blank"), status: 400
    end

  end
end
