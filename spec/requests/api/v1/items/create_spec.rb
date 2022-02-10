require 'rails_helper'

RSpec.describe 'Create An Item' do

  before(:each) do
    @merchant = Merchant.create!
  end

  it 'creates an item successfully' do
    item_attributes = {
      name: 'item-name',
      description: 'item-description',
      unit_price: 20.0,
      merchant_id: @merchant.id
    }

    post '/api/v1/items', params: { item: item_attributes }

    item_model = Item.first

    expect(item_model).to be_a(Item)
    expect(item_model.name).to be_a(String)
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

  it 'creates item successfully if unknown attribute is passed' do
    item_attributes = {
      name: 'item-name',
      description: 'item-description',
      unit_price: 20.0,
      merchant_id: @merchant.id,
      something: 'something' # unknown attribute
    }
    post '/api/v1/items', params: { item: item_attributes }
    expect(response).to be_successful
  end

  describe 'sad path and edge cases' do
    it 'returns error if an attribute is missing' do
      item_attributes = {
        name: 'item-name',
        description: 'item-description',
        # Missing unit_price
        merchant_id: @merchant.id
      }

      post '/api/v1/items', params: { item: item_attributes }


      item_response = JSON.parse(response.body, symbolize_names: true)

      expect(Item.first).to be_a(NilClass)
      expect(item_response[:message]).to eq('your query could not be completed')
      expect(item_response[:errors]).to be_a(Array)
    end

    it 'returns error if a merchant id is not found' do
      item_attributes = {
        name: 'item-name',
        description: 'item-description',
        unit_price: 20.0,
        merchant_id: 50847305
      }

      post '/api/v1/items', params: { item: item_attributes }

      item_response = JSON.parse(response.body, symbolize_names: true)

      expect(Item.first).to be_a(NilClass)
      expect(item_response[:message]).to eq('your query could not be completed')
      expect(item_response[:errors]).to be_a(Array)
    end

    it 'returns error if body and headers are blank' do
      post '/api/v1/items'

      item_response = JSON.parse(response.body, symbolize_names: true)

      expect(Item.first).to be_a(NilClass)
      expect(item_response[:message]).to eq('your query could not be completed')
      expect(item_response[:errors]).to be_a(Array)
    end
  end
end
