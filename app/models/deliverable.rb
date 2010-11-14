class Deliverable < ActiveRecord::Base
  has_many :deliveries    #, :class_name => "delivery", :foreign_key => "deliverable_id"
  validates_presence_of :number, :message => "can't be blank"
end
