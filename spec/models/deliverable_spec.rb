require 'spec_helper'

describe Deliverable do
  before(:each) do
    @valid_attributes = {
      :number => "value for number",
      :title => "value for title",
      :discipline => "value for discipline"
    }
  end

  it "should create a new instance given valid attributes" do
    Deliverable.create!(@valid_attributes)
  end
end
