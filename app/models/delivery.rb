class Delivery < ActiveRecord::Base
  belongs_to :deliverables
  belongs_to :status
  validates_presence_of :planned_date, :message => "can't be blank"
  # validates_format_of :planned_date, :with => /^[0-9]{2}+$/, :on => :create, :message => "is invalid"
end
