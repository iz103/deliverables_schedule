class Delivery < ActiveRecord::Base
  belongs_to :deliverables
  belongs_to :status
  validates_presence_of :planned_date, :message => "can't be blank"
end
