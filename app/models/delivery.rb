class Delivery < ActiveRecord::Base
  belongs_to :deliverable
  belongs_to :status
  validates_presence_of :planned_date, :message => "can't be blank"
  
  # validate :actual_date_cannot_be_in_the_future
  
  # def actual_date_cannot_be_in_the_future
  #   errors.add(:actual_date, "Cannot be in the future") if
  #         !actual_date > Date.today
  #         return false
  # end
  
  # validates_format_of :planned_date, :with => /^[0-9]{2}+$/, :on => :create, :message => "is invalid"
  
  # def self.search(search, page)
  #   paginate :per_page => 100, :page => page, # ,
  #            :conditions => ['planned_date like ?', "%#{search}%"], :order => 'planned_date'
  #            # :conditions => ["planned_date = '%#{search}%'"]
  # end
  
  # searchlogic searches
  # deliveries = Delivery.status_name_like "B"
  
  # based on this gist https://gist.github.com/199027
  # scope :tagged_with_disciplines, lambda {|tags| tagged_with(tags, :on => :disciplines )}
  
  # based on this gist https://gist.github.com/199027
  # scope :deliverable_tagged_with_disciplines, lambda {|tags| deliverable_tagged_with(tags, :on => :disciplines )}
  # search_methods :deliverable_tagged_with_disciplines
  
  scope :with_progress, lambda {|progress| {:conditions => "progresses_mask = #{2**PROGRESSES.index(progress.to_s)}" }}
  search_methods :with_progress
  PROGRESSES = %w[complete overdue incomplete]
  
  
  
  # # p = []
  # # progress << Delivery::PROGRESSES[0]
  # delivery.progresses = p
  # delivery.save
  
  
  
  def progresses=(progresses)
    self.progresses_mask = (progresses & PROGRESSES).map { |r| 2**PROGRESSES.index(r) }.sum
  end
  
  def progresses
    PROGRESSES.reject { |r| ((progresses_mask || 0) & 2**PROGRESSES.index(r)).zero? }
  end
  
  
  def self.planned_date_count(deliveries)
    # deliveries = Delivery.all(:order => "planned_date")
    dates = []
    counts = Hash.new(0)
    # cumulative = Hash.new(0)
    deliveries.each do |delivery|
      counts[delivery.planned_date] += 1
    end
    counts_array = counts.sort  
    sum = 0
    cumulative_array = []
    counts_array.each do |y|
      sum += y[1]
      cumulative_pair = [y[0].to_time.to_i*1000, sum]
      cumulative_array << cumulative_pair
    end

    cumulative_array
  end
  
  # def self.planned_date_count
  #   sum = 0
  #   date_with_count.map do |date, count|
  #     sum += count
  #     [date.to_time.to_i * 1000, sum]
  #   end
  # end
  
  def self.date_with_count
    result = find_by_sql("SELECT distinct(planned_date), count(planned_date) as count FROM deliveries GROUP BY planned_date ORDER BY planned_date")
    result.map{|row| [row["planned_date"].to_date, row["count"].to_i]}
  end
  

  
  def self.actual_date_count(deliveries)
    
    # deliveries = Delivery.all(:order => "actual_date")
    counts = Hash.new(0)
    deliveries.each do |delivery|
      unless delivery.actual_date == nil
        counts[delivery.actual_date] += 1
      end
    end
    counts_array = counts.sort
    sum = 0
    cumulative_array = []
    counts_array.each do |y|
      sum += y[1]
      cumulative_pair = [y[0].to_time.to_i*1000, sum]
      cumulative_array << cumulative_pair
    end
    
    cumulative_array
  end
  
  def self.overdue(deliveries)
    # deliveries = Delivery.all
    overdue =[]
    deliveries.each do |delivery|
      if delivery.actual_date == nil and delivery.planned_date < Date.today
        overdue << delivery
      end
    end
    overdue
  end



  def self.late(deliveries)
    # deliveries = Delivery.all
    late =[]
    deliveries.each do |delivery|
      if delivery.actual_date != nil and delivery.actual_date > delivery.planned_date
        late << delivery
      end
    end
    late
  end

  def self.early(deliveries)
    # deliveries = Delivery.all
    early = []
    deliveries.each do |delivery|
      if delivery.actual_date != nil and delivery.actual_date < delivery.planned_date
        early << delivery
      end
    end
    early
  end

  def self.due_today(deliveries)
    # deliveries = Delivery.all
    due =[]
    deliveries.each do |delivery|
      if delivery.planned_date == Date.today
        due << delivery
      end
    end
    due
  end

  def self.due_in_next_week(deliveries)
    # deliveries = Delivery.all
    due =[]
    deliveries.each do |delivery|
      if delivery.planned_date <= Date.today+1.week and delivery.planned_date > Date.today
        due << delivery
      end
    end
    due
  end

  def self.due_in_next_two_weeks(deliveries)
    # deliveries = Delivery.all
    due =[]
    deliveries.each do |delivery|
      if delivery.planned_date <= Date.today+2.weeks and delivery.planned_date > Date.today
        due << delivery
      end
    end
    due
  end

  def self.due_tomorrow(deliveries)
    # deliveries = Delivery.all
    due =[]
    deliveries.each do |delivery|
      if delivery.planned_date == Date.tomorrow
        due << delivery
      end
    end
    due
  end
         
  def self.complete(deliveries)
    # deliveries = Delivery.all
    complete_deliveries = []
    deliveries.each do |delivery|
      if delivery.actual_date?
        complete_deliveries << delivery
      end
    end
  
    complete_deliveries.count.to_f
  end

  def self.bsb(deliveries)
    if Delivery.overdue(deliveries).count > 0 or Delivery.due_today(deliveries).count > 0 
       bsb = Delivery.overdue(deliveries).count + Delivery.due_today(deliveries).count
    else
      puts 0
    end
    bsb
  end

  def self.percentage_complete(deliveries)
    complete_percentage = (Delivery.complete(deliveries) / Delivery.all.count.to_f)*100
  end

end
