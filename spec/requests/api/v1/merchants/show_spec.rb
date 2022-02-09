require 'rails_helper'

RSpec.describe 'Get A Single Merchant' do

  before(:each) do
    5.times do
      Merchant.create!(name: Faker::Name.name)
    end
    @last_merchant = Merchant.last
  end

  it 'returns a single merchant' do
    get "/api/v1/merchants/#{@last_merchant.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to be_a(String)
    expect(merchant[:data][:type]).to be_a(String)
    expect(merchant[:data][:type]).to eq('merchant')

    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'returns error if given merchant id is invalid or not an integer' do
    get "/api/v1/merchants/invalid_id"

    expect(response.status).to eq(404)
    expect(response).to_not be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:message]).to be_a(String)
    expect(merchant[:message]).to eq("invalid merchant id")
  end

end
