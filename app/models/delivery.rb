class Delivery < ActiveRecord::Base
  # belongs_to :type, :class_name  => "Delivery"
  #TODO change type to iteration
  #or have a seperate table for Iteration (iteration_name. iteration rank, user_id, reciver_id )
  belongs_to :deliverables  #, :class_name => "Deliverables", :foreign_key => "deliverables_id"
  validates_presence_of :planned_date, :message => "can't be blank"
end
