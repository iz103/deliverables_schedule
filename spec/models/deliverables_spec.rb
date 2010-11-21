require 'spec_helper'

describe Deliverables do
  before(:each) do
    @valid_attributes = {
      :number => "value for number",
      :title => "value for title",
      :discipline => "value for discipline"
    }
  end

  it "should create a new instance given valid attributes" do
    Deliverables.create!(@valid_attributes)
  end
end
