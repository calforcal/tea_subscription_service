require "rails_helper"

RSpec.describe "Get All Subscriptions" do
  describe "happy paths" do
    it "can get all subscriptions regardless of status" do
      customer = FactoryBot.create(:customer)
      tea_1 = FactoryBot.create(:tea)
      tea_2 = FactoryBot.create(:tea)
      subscription_1 = FactoryBot.create(:subscription, status: true, customer_id: customer.id, tea_id: tea_1.id)
      subscription_2 = FactoryBot.create(:subscription, status: false, customer_id: customer.id, tea_id: tea_2.id)

      get api_v1_customer_subscriptions_path(customer)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:data)
      expect(parsed[:data]).to be_an Array

      expect(parsed[:data].count).to eq(2)

      parsed[:data].each do |element|
        expect(element).to be_a Hash
        expect(element).to have_key(:id)
        expect(element[:id]).to be_an Integer

        expect(element).to have_key(:type)
        expect(element[:type]).to be_a String

        expect(element).to have_key(:attributes)
        expect(element[:attributes]).to be_a Hash

        attributes = element[:attributes]

        expect(attributes).to have_key(:title)
        expect(attributes[:title]).to be_a String

        expect(attributes).to have_key(:price)
        expect(attributes[:price]).to be_a Float

        expect(attributes).to have_key(:status)
        expect(attributes[:status]).to be_a(TrueClass).or be_a(FalseClass) 

        expect(attributes).to have_key(:frequency)
        expect(attributes[:frequency]).to be_a String

        expect(attributes).to have_key(:tea_id)
        expect(attributes[:tea_id]).to be_an Integer

        expect(attributes).to have_key(:customer_id)
        expect(attributes[:customer_id]).to be_an Integer

        expect(subscription.reload.status).to be(false)
      end
    end
  end
end