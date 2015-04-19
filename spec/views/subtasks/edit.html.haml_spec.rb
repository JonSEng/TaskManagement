require 'spec_helper'

describe "subtasks/edit" do
  before(:each) do
    @subtask = assign(:subtask, stub_model(Subtask,
      :title => "MyString",
      :description => "MyString",
      :finished => false
    ))
  end

  it "renders the edit subtask form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", subtask_path(@subtask), "post" do
      assert_select "input#subtask_title[name=?]", "subtask[title]"
      assert_select "input#subtask_description[name=?]", "subtask[description]"
      assert_select "input#subtask_finished[name=?]", "subtask[finished]"
    end
  end
end
