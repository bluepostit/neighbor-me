class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :tool, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :approved, default: false, null: false
      t.datetime :collect_time, null: false
      t.datetime :return_time, null: false
      t.datetime :collected_time
      t.datetime :returned_time

      t.timestamps
    end
  end
end
