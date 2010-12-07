class AddStatusIdToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :status_id, :integer
  end

  def self.down
    remove_column :deliveries, :status_id
  end
end
