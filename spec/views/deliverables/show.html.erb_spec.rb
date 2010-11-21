require 'spec_helper'

describe "/deliverables/show.html.erb" do
  include DeliverablesHelper
  before(:each) do
    assigns[:deliverables] = @deliverables = stub_model(Deliverables,
      :number => "value for number",
      :title => "value for title",
      :discipline => "value for discipline"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ number/)
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ discipline/)
  end
end
