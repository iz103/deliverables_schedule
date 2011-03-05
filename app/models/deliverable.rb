class Deliverable < ActiveRecord::Base
  has_many :statuses, :through => :deliveries
  has_many :deliveries, :dependent => :destroy
  # accepts_nested_attributes_for :deliveries
  acts_as_taggable_on :disciplines
  
  validates_presence_of :number, :message => "can't be blank"
end
