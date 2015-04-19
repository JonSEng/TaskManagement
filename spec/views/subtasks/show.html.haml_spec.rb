require 'spec_helper'

describe "subtasks/show" do
  before(:each) do
    @subtask = assign(:subtask, stub_model(Subtask,
      :title => "Title",
      :description => "Description",
      :finished => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Description/)
    rendered.should match(/false/)
  end
end
