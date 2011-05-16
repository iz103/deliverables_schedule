require 'spec_helper'

describe Deliverable do
  describe "#deliveries_with_progress" do
    it "works" do
      Deliverable.deliveries_with_progress("complete")
    end
  end
end
