class Api::V1::SubscriptionsController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.create!(JSON.parse(params[:params]))

    render json: {
      "data": {
        "id": subscription.id,
        "type": "subscription",
        "attributes": {
          title: subscription.title,
          price: subscription.price,
          status: subscription.status,
          frequency: subscription.frequency,
          tea_id: subscription.tea_id,
          customer_id: subscription.customer_id
        }
      }
    }, status: :created
  end
end