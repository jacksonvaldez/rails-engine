require 'rails_helper'

RSpec.describe Merchant do

  before(:each) do
    @merchant = Merchant.create!
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  it 'exists' do
    expect(@merchant).to be_a(Merchant)
  end
end
