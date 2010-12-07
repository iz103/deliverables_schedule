class Deliverable < ActiveRecord::Base
  has_many :statuses, :through => :deliveries
  has_many :deliveries
  
  validates_presence_of :number, :message => "can't be blank"
end
