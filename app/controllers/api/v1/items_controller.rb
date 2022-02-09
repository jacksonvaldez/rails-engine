class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.all
    render json: ItemSerializer.items_index(items)
  end

  def show
    item = Item.where(id: params[:id]).first

    if item.class == Item
      render json: ItemSerializer.items_show(item)
    else
      render json: ItemSerializer.invalid_id, status: 404
    end
  end

end
