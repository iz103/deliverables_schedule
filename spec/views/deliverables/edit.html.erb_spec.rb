require 'spec_helper'

describe "/deliverables/edit.html.erb" do
  include DeliverablesHelper

  before(:each) do
    assigns[:deliverables] = @deliverables = stub_model(Deliverables,
      :new_record? => false,
      :number => "value for number",
      :title => "value for title",
      :discipline => "value for discipline"
    )
  end

  it "renders the edit deliverables form" do
    render

    response.should have_tag("form[action=#{deliverables_path(@deliverables)}][method=post]") do
      with_tag('input#deliverables_number[name=?]', "deliverables[number]")
      with_tag('input#deliverables_title[name=?]', "deliverables[title]")
      with_tag('input#deliverables_discipline[name=?]', "deliverables[discipline]")
    end
  end
end
