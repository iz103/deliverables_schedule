class Delivery < ActiveRecord::Base
  belongs_to :deliverables
  belongs_to :status
  validates_presence_of :planned_date, :message => "can't be blank"
  # validates_format_of :planned_date, :with => /^[0-9]{2}+$/, :on => :create, :message => "is invalid"
  

  def self.planned_date_count
    deliveries = Delivery.all(:order => "planned_date")
    dates = []
    counts = Hash.new(0)
    cumulative = []
    deliveries.each do |delivery|
      counts[delivery.planned_date] += 1
    end
    # planned_dates_array = counts.keys
    # counts_array = counts.values
    sum = 0
    counts.values.each do |count|
      sum += count
      cumulative << sum
    end
    counts.keys
    cumulative
  end
      
      
    
    
  
 
  
  
end













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
