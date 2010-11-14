class CreateDeliverables < ActiveRecord::Migration
  def self.up
    create_table :deliverables do |t|
      t.string :number
      t.string :title
      t.string :discipline

      t.timestamps
    end
  end

  def self.down
    drop_table :deliverables
  end
end
