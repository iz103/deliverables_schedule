Given /^I have deliverables numbered (.+)$/ do |numbers|
  numbers.split(', ').each do |number|
    Deliverable.create!(:number => number)
  end
end

Given /^a deliverable number (.+)$/ do |number|
  Deliverable.create!(:number => number)
end

Given /^a delivery planned date (.+)$/ do |planned_date|
  Delivery.create!(:planned_date => planned_date)
  
end

