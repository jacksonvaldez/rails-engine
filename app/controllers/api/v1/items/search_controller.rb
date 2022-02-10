class Api::V1::Items::SearchController < ApplicationController
  def index
    items = Item.search_by_name(params[:name].to_s)

    if params[:name].present? && params[:name] != ""
      if items.first.class == Item
        render json: ItemSerializer.items_index(items)
      else
        render json: Serializer.no_records_found
      end
    else
      render json: Serializer.return_error("name query is either missing or blank"), status: 400
    end
  end
end
