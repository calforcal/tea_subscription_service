class Subscription < ApplicationRecord
  validates_presence_of :title, :price, :status, :frequency, :customer_id, :tea_id

  belongs_to :customer
  belongs_to :tea

  enum frequency: { weekly: 0, monthly: 1, bi_monthly: 2, quarterly: 3, semi_annually: 4, annually: 5}
end