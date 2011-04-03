class Delivery < ActiveRecord::Base
  belongs_to :deliverables
  belongs_to :status
  validates_presence_of :planned_date, :message => "can't be blank"
  # validates_format_of :planned_date, :with => /^[0-9]{2}+$/, :on => :create, :message => "is invalid"
  
  # def self.search(search, page)
  #   paginate :per_page => 100, :page => page, # ,
  #            :conditions => ['planned_date like ?', "%#{search}%"], :order => 'planned_date'
  #            # :conditions => ["planned_date = '%#{search}%'"]
  # end
  
  # searchlogic searches
  # deliveries = Delivery.status_name_like "B"
  
  
  
  #based on http://stackoverflow.com/questions/5434326/a-question-about-will-paginates-with-multiple-conditions
  # def self.search(discipline_list, tag_list,  page)
  #   conditions = []
  #   conditions << "discipline_list = #{discipline_list}"
  #   conditions << "tag_list = #{tag_list}"
  #   paginate :per_page => 100, :page => page,
  #            :conditions => conditions.join('and')  # , :order => 'number'
  # end
  
  # based on this gist https://gist.github.com/199027
  scope_procedure :tagged_with_disciplines, lambda {|tags| tagged_with(tags, :on => :disciplines )}
  

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
      counts_array.each do |y| sum += y[1]
        cumulative_pair = [y[0].to_time.to_i*1000, sum]
        cumulative_array << cumulative_pair
        end
        
    cumulative_array
                    
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
     counts_array.each do |y| sum += y[1]
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











# sum = 0
#     counts.each do |date, count|
#       sum += count
#       cumulative[date] = sum
#     end
#     cumulative_array = []
#     cumulative.each do |key, value|
#       cumulative_pair = [key.to_time.to_i*1000, value]
#       cumulative_array << cumulative_pair
#     end



 # def planned_date_count
 #   deliveries = Delivery.all(:order => "planned_date")
 #   dates = []
 #   counts = []
 #   cumulative = []
 #   deliveries.each do |delivery|
 #     count = 0
 #     if dates.empty?
 #       # count += 1
 #       dates << delivery.planned_date
 #       # counts << count
 #     else    
 #       dates.each do |date|
 #         if date == delivery.planned_date
 #           # x = dates.index(date)
 #           # counts[x] += 1
 #         else
 #           # count += 1
 #           dates << delivery.planned_date
 #           # counts << count
 #         end
 #         end
 #       # dates.uniq!
 #     end
 #     end
 #     deliveries.each do |delivery|
 #       
 #          end
 #        end
 #      end
 #    end
 #       
 #     
 #     
 #     
 #     
 #     
 #     sum = 0
 #     counts.each do |y| sum += y
 #     cumulative << sum
 #   end  
 # end
 
 
 
 
 
 
 
 
 
 
 
 
 # def planned_date_count
 #   deliveries = Delivery.all(:order => "planned_date")
 #   dates = []
 #   counts = []
 #   cumulative = []
 #   deliveries.each do |delivery|
 #     count = 0
 #     if dates.empty?
 #       count += 1
 #       dates << delivery.planned_date
 #       counts << count
 #     else    
 #       dates.each do |date|
 #         if date == delivery.planned_date
 #           x = dates.index(date)
 #           counts[x] += 1
 #         else
 #           count += 1
 #           dates << delivery.planned_date
 #           counts << count
 #         end
 #         end
 #       dates.uniq!
 #     end
 #     end
 #     sum = 0
 #     counts.each do |y| sum += y
 #     cumulative << sum
 #   end  
 # end


     
 
 
 
 
 
 
 # def planned_date_hash
 #   deliveries = Delivery.all(:order => "planned_date")
 #   hash = Hash.new
 #   count = 0
 #   deliveries.each do |delivery|
 #     
 #     unless hash.any? do |key, value| value = delivery.planned_date end
 #       count += 1
 #       hash[count] = delivery.planned_date
 #     else 
 #       key += 1   # how to to get the key of a value in a hash and add it to another key
 #     hash.sort
 #   end
 # end
 # 
 # unless hash.any
 # # 
 # # def cumulative_sum
 # #   planned_date_hash
 # #   sum = 0
 # #   
 # #   
 # # end
 # 
