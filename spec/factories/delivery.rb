Factory.define :delivery do |d|
  d.planned_date { Date.parse("2011-04-20") }
  d.actual_date { Date.parse("2011-04-29") }
  d.association :deliverable
  d.association :status
end