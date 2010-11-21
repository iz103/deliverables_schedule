require 'spec_helper'

describe "/deliverables/index.html.erb" do
  include DeliverablesHelper

  before(:each) do
    assigns[:deliverables] = [
      stub_model(Deliverables,
        :number => "value for number",
        :title => "value for title",
        :discipline => "value for discipline"
      ),
      stub_model(Deliverables,
        :number => "value for number",
        :title => "value for title",
        :discipline => "value for discipline"
      )
    ]
  end

  it "renders a list of deliverables" do
    render
    response.should have_tag("tr>td", "value for number".to_s, 2)
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", "value for discipline".to_s, 2)
  end
end
