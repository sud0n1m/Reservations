class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.string :email
      t.date :from_date
      t.date :to_date
      t.integer :property_id

      t.timestamps
    end

    add_index :reservations, :email
    add_index :reservations, :property_id

  end

  def self.down
    drop_table :reservations
  end
end
