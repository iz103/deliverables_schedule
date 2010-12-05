class Deliverable < ActiveRecord::Base
  has_many :statuses
  has_many :deliveries, :through => :statuses
  
  validates_presence_of :number, :message => "can't be blank"
end
