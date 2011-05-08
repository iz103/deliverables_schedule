Factory.sequence :position do |n|
  n
end

Factory.define :status do |s|
  s.name "Test Status"
  s.position { Factory.next :position }
  s.description "Test Description"
end