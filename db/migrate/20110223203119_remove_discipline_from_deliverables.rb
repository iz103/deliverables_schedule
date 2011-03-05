class RemoveDisciplineFromDeliverables < ActiveRecord::Migration
  def self.up
    remove_column :deliverables, :discipline
  end

  def self.down
    add_column :deliverables, :discipline, :string
  end
end
