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
  
  # scope_procedure :tagged_with, lambda {|tags| tagged_with (tags)}
  
  # def self.search(search, page)
  #   paginate :per_page => 100, :page => page,
  #            :conditions => ['number like ?', "%#{search}%"] # , :order => 'number'
  # end
  
end
