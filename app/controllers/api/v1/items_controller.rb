class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id].present?
      merchant = Merchant.where(id: params[:merchant_id]).first

      if merchant.class == Merchant
        items = Item.where(merchant_id: params[:merchant_id])
        render json: ItemSerializer.items_index(items)
      else
        render json: Serializer.return_error("invalid merchant id"), status: 404
      end
    else
      items = Item.all
      render json: ItemSerializer.items_index(items)
    end
  end

  def show
    item = Item.where(id: params[:id]).first

    if item.class == Item
      render json: ItemSerializer.items_show(item)
    else
      render json: Serializer.return_errors(['invalid item id']), status: 404
    end
  end

  def create
    item = Item.new(item_params)

    if item.save
      render json: ItemSerializer.items_show(item), status: 201
    else
      errors = item.error_messages
      render json: Serializer.return_errors(errors), status: 404
    end
  end

  def update
    item = Item.where(id: params[:id]).first

    if item.class == Item
      if item.update(item_params)
        render json: ItemSerializer.items_show(item)
      else
        errors = item.error_messages
        render json: Serializer.return_errors(errors), status: 400
      end
    else
      render json: Serializer.return_errors(['invalid item id']), status: 404
    end
  end

  def destroy
    item = Item.where(id: params[:id]).first

    if item.class == Item
      item.destroy
      Invoice.destroy_by_item_count
    else
      render json: Serializer.return_errors(['invalid item id']), status: 404
    end
  end

  private

  def item_params
    params[:item] ||= Hash.new
    params[:item].permit(:name, :description, :unit_price, :merchant_id)
  end

end
