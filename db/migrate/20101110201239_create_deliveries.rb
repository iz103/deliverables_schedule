class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.datetime :planned_date
      t.datetime :actual_date
      t.integer :deliverable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
