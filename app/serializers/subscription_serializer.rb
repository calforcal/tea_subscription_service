class SubscriptionSerializer
  def initialize(object)
    @subscriptions = object
  end

  def serialize_one
    {
      data: {
        "id": @subscriptions.id,
        "type": "subscription",
        "attributes": {
          title: @subscriptions.title,
          price: @subscriptions.price,
          status: @subscriptions.status,
          frequency: @subscriptions.frequency,
          tea_id: @subscriptions.tea_id,
          customer_id: @subscriptions.customer_id
        }
      }
    }
  end

  def serialize_multiple
    formatted_subscriptions = @subscriptions.map do |subscription|
      {
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
    end

    {
      data: formatted_subscriptions
    }
  end
end