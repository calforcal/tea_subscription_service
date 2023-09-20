require "rails_helper"

RSpec.describe "New Customer Subscription" do
  describe "happy paths" do
    it "can create a new subscription for a customer" do
      customer = FactoryBot.create(:customer)
      tea = FactoryBot.create(:tea)

      expect(customer.subscriptions.count).to eq(0)

      params = {
        "title": "Summer Tea",
        "price": 200.00,
        "status": true,
        "frequency": "weekly",
        "tea_id": tea.id
      }

      headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      post api_v1_customer_subscriptions_path(customer, headers: headers, params: params)

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
      expect(attributes[:status]).to be_an TrueClass || FalseClass

      expect(attributes).to have_key(:frequency)
      expect(attributes[:frequency]).to be_a String

      expect(attributes).to have_key(:tea_id)
      expect(attributes[:tea_id]).to be_an Integer

      expect(attributes).to have_key(:customer_id)
      expect(attributes[:customer_id]).to be_an Integer

      expect(customer.subscriptions.count).to eq(1)
    end
  end

  describe "sad paths" do
    it "will return a 404 if customer ID is not found" do
      customer = FactoryBot.create(:customer)
      tea = FactoryBot.create(:tea)

      expect(customer.subscriptions.count).to eq(0)

      params = {
        "title": "Summer Tea",
        "price": 200.00,
        "status": true,
        "frequency": "weekly",
        "tea_id": tea.id
      }

      headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      post api_v1_customer_subscriptions_path(-1, headers: headers, params: params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:errors].first[:status]).to eq(404)
      expect(parsed[:errors].first[:message]).to eq("Invalid request. Please try again.")

      expect(customer.subscriptions.count).to eq(0)
    end

    it "will return a 400 if subscription params are incomplete" do
      customer = FactoryBot.create(:customer)
      tea = FactoryBot.create(:tea)

      expect(customer.subscriptions.count).to eq(0)

      params = {
        "title": "Summer Tea",
        "status": true,
        "tea_id": tea.id
      }

      headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      post api_v1_customer_subscriptions_path(customer, headers: headers, params: params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:errors].first[:status]).to eq(400)
      expect(parsed[:errors].first[:message]).to eq("Invalid request. Please try again.")

      expect(customer.subscriptions.count).to eq(0)
    end
  end
end