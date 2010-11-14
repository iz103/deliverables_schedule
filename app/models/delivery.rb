class Delivery < ActiveRecord::Base
  belongs_to :deliverables  #, :class_name => "Deliverables", :foreign_key => "deliverables_id"
  validates_presence_of :planned_date, :message => "can't be blank"
end
