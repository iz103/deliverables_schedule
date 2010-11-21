Given /^I have deliverables numbered (.+)$/ do |numbers|
  numbers.split(', ').each do |number|
    Deliverable.create!(:number => number)
  end
end