class Status < ActiveRecord::Base
  has_many :deliverables, :through => :deliveries
  has_many :deliveries
  # acts_as_list
  validates_uniqueness_of :position, :on => :create, :message => "position is already taken"
end
