class AddQuantityToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :quantity, :integer
  end
end
