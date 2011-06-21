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
  
  describe ".planned_deliveries" do
    before do
      @delivery_1 = Factory(:delivery, :planned_date => Date.parse("2010-02-01"))
      @delivery_2 = Factory(:delivery, :planned_date => Date.parse("2010-02-01"))
      @delivery_3 = Factory(:delivery, :planned_date => Date.parse("2010-02-02"))
    end
    
    it "should give a count for each delivery planned date"
      deliveries = Delivery.planned_deliveries([@delivery_1, @delivery_2, @delivery_3])
      deliveries.should == [
        [Date.parse("2010-02-01").to_time.to_i * 1000, 2],
        [Date.parse("2010-02-02").to_time.to_i * 1000, 1]
      ]
  
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
  
  describe ".complete" do
    before do
      @delivery_1 = Factory(:delivery, :actual_date => Date.parse("2010-01-01"))
      @delivery_2 = Factory(:delivery, :actual_date => nil)
      @delivery_3 = Factory(:delivery, :actual_date => nil, :planned_date => Date.today + 2.days)
    end
    
    it "selects deliveries with an actual date" do
      Delivery.complete.should eq [@delivery_1]
    end
    
    it "incomplete is the opposite with a planned date in the future" do
      Delivery.incomplete.should eq [@delivery_3]
    end
  end
  
  describe ".overdue" do
    before do
      @delivery_1 = Factory(:delivery, :actual_date => Date.parse("2010-01-01"))
      @delivery_2 = Factory(:delivery, :actual_date => nil, :planned_date => Date.parse("2010-01-01"))
      @delivery_3 = Factory(:delivery, :actual_date => nil, :planned_date => Date.today + 2.days)
    end
    
    it "selects incomplete deliveries where the planned date is in the past" do
      Delivery.overdue.should eq [@delivery_2]
    end
  end
  
  describe "#progress" do
    it "is complete if it has an actual date" do
      Delivery.new(:actual_date => Date.today).progress.should eq "complete"
    end
    
    it "is incomplete if it doesn't have an actual date and the planned date is in the future" do
      Delivery.new(:actual_date => nil, :planned_date => Date.today + 1.day).progress.should eq "incomplete"
    end
    
    it "is overdue if it doesn't have an actual date and the planned date is in the past" do
      Delivery.new(:actual_date => nil, :planned_date => Date.today - 1.day).progress.should eq "overdue"
    end
    
    it "is due if it's today" do
      delivery = Delivery.new(:actual_date => nil, :planned_date => Date.today.midnight)
      delivery.progress.should eq "due"
    end
  end
end
