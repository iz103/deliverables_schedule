require 'spec_helper'

describe "/deliverables/new.html.erb" do
  include DeliverablesHelper

  before(:each) do
    assigns[:deliverables] = stub_model(Deliverables,
      :new_record? => true,
      :number => "value for number",
      :title => "value for title",
      :discipline => "value for discipline"
    )
  end

  it "renders new deliverables form" do
    render

    response.should have_tag("form[action=?][method=post]", deliverables_path) do
      with_tag("input#deliverables_number[name=?]", "deliverables[number]")
      with_tag("input#deliverables_title[name=?]", "deliverables[title]")
      with_tag("input#deliverables_discipline[name=?]", "deliverables[discipline]")
    end
  end
end
