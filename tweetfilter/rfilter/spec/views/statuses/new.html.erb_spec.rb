require 'spec_helper'

describe "statuses/new.html.erb" do
  before(:each) do
    assign(:status, stub_model(Status,
      :status_id => "MyString",
      :name => "MyString",
      :screen_name => "MyString",
      :url => "MyString",
      :source => "MyString",
      :via => "MyString"
    ).as_new_record)
  end

  it "renders new status form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => statuses_path, :method => "post" do
      assert_select "input#status_status_id", :name => "status[status_id]"
      assert_select "input#status_name", :name => "status[name]"
      assert_select "input#status_screen_name", :name => "status[screen_name]"
      assert_select "input#status_url", :name => "status[url]"
      assert_select "input#status_source", :name => "status[source]"
      assert_select "input#status_via", :name => "status[via]"
    end
  end
end
