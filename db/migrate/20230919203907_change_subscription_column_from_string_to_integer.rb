class ChangeSubscriptionColumnFromStringToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :frequency, 'integer USING CAST(frequency AS integer)'
  end
end
