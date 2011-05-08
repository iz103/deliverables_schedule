require 'spec_helper'

describe Delivery do
  describe ".planned_date_count" do
    before do
      @delivery_1 = Factory(:delivery, :planned_date => Date.parse("2010-02-01"))
      @delivery_2 = Factory(:delivery, :planned_date => Date.parse("2010-02-01"))
      @delivery_3 = Factory(:delivery, :planned_date => Date.parse("2010-02-02"))
    end
    
    it "cumulatively counts the number of deliveries due" do
      deliveries = Delivery.planned_date_count([@delivery_1, @delivery_2, @delivery_3])
      deliveries.should == [
        [Date.parse("2010-02-01").to_time.to_i * 1000, 2],
        [Date.parse("2010-02-02").to_time.to_i * 1000, 3]
      ]
    end
  end
  
  describe ".date_with_count" do
    before do
      @delivery_1 = Factory(:delivery, :planned_date => Date.parse("2010-02-01"))
      @delivery_2 = Factory(:delivery, :planned_date => Date.parse("2010-02-01"))
      @delivery_3 = Factory(:delivery, :planned_date => Date.parse("2010-02-02"))
    end
    
    it "returns an array with the date and number of deliverables due on that date" do
      Delivery.date_with_count.should == [
        [Date.parse("2010-02-01"), 2],
        [Date.parse("2010-02-02"), 1]
      ]
    end
  end
end
