class Status < ActiveRecord::Base
  has_many :deliverables
  has_many :deliveries, :through => :deliverables
  # acts_as_list
  validates_uniqueness_of :position, :on => :create, :message => "position is already taken"
end
