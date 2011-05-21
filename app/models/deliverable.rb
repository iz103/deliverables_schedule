class Deliverable < ActiveRecord::Base
  has_many :statuses, :through => :deliveries
  has_many :deliveries, :dependent => :destroy
  # accepts_nested_attributes_for :deliveries
  acts_as_taggable
  acts_as_taggable_on :disciplines, :document_types
  
  validates_presence_of :number, :message => "can't be blank"
  
  

  # cattr_reader :per_page
  # @@per_page = 100
  
  scope :tagged_with_disciplines, lambda {|tags| tagged_with(tags, :on => :disciplines )}
  search_methods :tagged_with_disciplines
  
  # scope :deliveries_with_progress, lambda {|progress|
  #   
  # }
  def self.deliveries_with_progress(progress)
    return [] unless ["complete", "incomplete", "overdue", "due"].include?(progress)
    self.send(progress)
  end
  
  def self.complete
    joins(:deliveries).where("\"deliveries\".actual_date is not null")
  end
  
  def self.incomplete
    joins(:deliveries).where("\"deliveries\".actual_date is null AND planned_date > ?", Date.today.midnight)
  end
  
  def self.overdue
    joins(:deliveries).where("\"deliveries\".actual_date is null AND planned_date < ?", Date.today.midnight)
  end
  
  def self.due
    joins(:deliveries).where("\"deliveries\".actual_date is null AND planned_date = ?", Date.today.midnight)
  end
  
  search_methods :deliveries_with_progress
  
  
  # scope :marked_complete, :conditions =>['SELECT "actual_date" FROM "deliveries" WHERE EXISTS']
  # search_methods :marked_complete
  
  # scope :tagged_with, lambda {|tags| tagged_with (tags)}
  
end

# deliveries.each do |delivery|
#   if delivery.actual_date?
#     delivery.progresses = ("complete")
#     delivery.save
#   end
# end
