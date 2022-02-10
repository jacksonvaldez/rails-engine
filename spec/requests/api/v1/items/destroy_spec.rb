require 'rails_helper'

RSpec.describe 'Destroys An Item' do

  before(:each) do
    @merchant = Merchant.create!
    @item = Item.create(name: 'item-name', description: 'item-description', unit_price: 40, merchant_id: @merchant.id)
  end

  it 'destroys an item successfully' do
    delete "/api/v1/items/#{@item.id}"

    item_model = Item.first
    expect(item_model).to be_a(NilClass)
    expect(response.status).to eq(204)
  end

  it 'destroys any invoice if this was the only item on an invoice' do

  end

  describe 'sad path and edge cases' do

    it 'returns error if item id does not exist' do
      delete "/api/v1/items/95723480"

      item_model = Item.first
      expect(item_model).to be_a(Item)
      expect(response).to_not be_successful

      item_response = JSON.parse(response.body, symbolize_names: true)
      expect(item_response[:message]).to eq('your query could not be completed')
      expect(item_response[:errors]).to be_a(Array)
    end

    it 'returns error if item id is invalid' do
      delete "/api/v1/items/invalid_item_id"

      item_model = Item.first
      expect(item_model).to be_a(Item)
      expect(response).to_not be_successful

      item_response = JSON.parse(response.body, symbolize_names: true)
      expect(item_response[:message]).to eq('your query could not be completed')
      expect(item_response[:errors]).to be_a(Array)
    end
    
  end
end
