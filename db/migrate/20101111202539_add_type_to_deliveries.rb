class AddTypeToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :type, :string
  end

  def self.down
    remove_column :deliveries, :type
  end
end
