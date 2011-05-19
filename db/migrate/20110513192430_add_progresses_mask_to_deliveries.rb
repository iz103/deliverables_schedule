class AddProgressesMaskToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :progresses_mask, :integer
  end

  def self.down
    remove_column :deliveries, :progresses_mask
  end
end
