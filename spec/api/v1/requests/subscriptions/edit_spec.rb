require "rails_helper"

RSpec.describe "New Customer Subscription" do
  describe "happy paths" do
    it "can create a new subscription for a customer" do
      customer = FactoryBot.create(:customer)
      tea = FactoryBot.create(:tea)
      subscription = FactoryBot.create(:subscription, status: true, customer_id: customer.id, tea_id: tea.id)

      expect(subscription.status).to be(true)

      headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      params = {
        "title": "Summer Tea",
        "price": 200.00,
        "status": false,
        "frequency": "weekly",
        "tea_id": tea.id
      }
      patch api_v1_customer_subscription_path(customer, subscription, params: params, headers: headers)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:data)
      expect(parsed[:data]).to be_a Hash
      expect(parsed[:data]).to have_key(:id)
      expect(parsed[:data][:id]).to be_an Integer

      expect(parsed[:data]).to have_key(:type)
      expect(parsed[:data][:type]).to be_a String

      expect(parsed[:data]).to have_key(:attributes)
      expect(parsed[:data][:attributes]).to be_a Hash

      attributes = parsed[:data][:attributes]

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