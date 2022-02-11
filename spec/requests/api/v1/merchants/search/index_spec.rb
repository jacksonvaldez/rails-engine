require 'rails_helper'

RSpec.describe 'Finds One Merchant based on search query' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Another Name')
    @merchant_2 = Merchant.create!(name: 'Turing')
    @merchant_3 = Merchant.create!(name: 'The Ring')
    @merchant_4 = Merchant.create!(name: 'Some Name')
    @merchant_5 = Merchant.create!(name: 'namesome')
    @merchant_6 = Merchant.create!(name: 'nAmE')
    @merchant_7 = Merchant.create!(name: 'lAlE')
  end

  it 'returns merchant based on query' do
    get '/api/v1/merchants/find?name=nAmE'

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to be_a(Hash)
    expect(merchant[:data][:id]).to eq("#{@merchant_1.id}")
    expect(merchant[:data][:type]).to eq("merchant")
    expect(merchant[:data][:attributes]).to be_a(Hash)
    expect(merchant[:data][:attributes][:name]).to eq("Another Name")
  end

  describe 'sad path and edge cases' do
    it 'doesnt return merchant if nothing matches the qeury' do
      get '/api/v1/merchants/find?name=NOMATCH'

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to eq({})
    end
    it 'returns error if the query is blank' do
      get '/api/v1/merchants/find?name='

      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant[:message]).to eq("your query could not be completed")
      expect(merchant[:error]).to eq("name query is either missing or blank")

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end
    it 'returns error if the query is not there' do
      get '/api/v1/merchants/find'

      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant[:message]).to eq("your query could not be completed")
      expect(merchant[:error]).to eq("name query is either missing or blank")

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end
  end
end
