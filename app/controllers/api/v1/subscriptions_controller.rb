class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions).serialize_multiple, status: 200
  end

  def create
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription).serialize_one, status: :created
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update!(subscription_params)
    render json: SubscriptionSerializer.new(subscription).serialize_one, status: :created
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency, :tea_id, :customer_id)
  end
end