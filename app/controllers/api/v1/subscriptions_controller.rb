class Api::V1::SubscriptionsController < ApplicationController
  before_action :find_customer

  def index
    subscriptions = @customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions).serialize_multiple, status: 200
  end

  def create
    subscription = @customer.subscriptions.create!(subscription_params)
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

  def find_customer
    @customer = Customer.find(params[:customer_id])
  end
end