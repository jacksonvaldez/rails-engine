require 'rails_helper'

RSpec.describe 'Update An Item' do

  before(:each) do
    @merchant = Merchant.create!
    @item = Item.create(name: 'item-name', description: 'item-description', unit_price: 40, merchant_id: @merchant.id)
  end

  it 'updates an item successfully' do
    new_item_attributes = {
      name: 'new-item-name'
    }

    patch "/api/v1/items/#{@item.id}", params: { item: new_item_attributes }

    item_model = Item.first

    expect(item_model).to be_a(Item)
    expect(item_model.name).to be_a(String)
    expect(item_model.name).to eq('new-item-name')
    expect(item_model.description).to be_a(String)
    expect(item_model.unit_price).to be_a(Float)
    expect(item_model.merchant_id).to be_a(Integer)

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response[:data]).to be_a(Hash)
    expect(item_response[:data][:id]).to be_a(String)
    expect(item_response[:data][:type]).to be_a(String)
    expect(item_response[:data][:attributes]).to be_a(Hash)
    expect(item_response[:data][:attributes][:name]).to be_a(String)
    expect(item_response[:data][:attributes][:description]).to be_a(String)
    expect(item_response[:data][:attributes][:unit_price]).to be_a(Float)
    expect(item_response[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'updates item successfully if unknown attribute is passed' do
    new_item_attributes = {
      description: 'new-item-description',
      something: 'something' # unknown attribute
    }
    patch "/api/v1/items/#{@item.id}", params: { item: new_item_attributes }
    expect(Item.first.description).to eq('new-item-description')
    expect(response).to be_successful
  end

  describe 'sad path and edge cases' do
    it 'returns error if a merchant id is not found' do
      new_item_attributes = {
        merchant_id: 50847305
      }

      patch "/api/v1/items/#{@item.id}", params: { item: new_item_attributes }

      item_response = JSON.parse(response.body, symbolize_names: true)

      expect(Item.first).to be_a(Item)
      expect(Item.first.merchant_id).to eq(@merchant.id)
      expect(Item.first.merchant_id).to_not eq(50847305)
      expect(item_response[:message]).to eq('your query could not be completed')
      expect(item_response[:errors]).to be_a(Array)
    end
  end
end
