require 'spec_helper'

describe "statuses/index.html.erb" do
  before(:each) do
    assign(:statuses, [
      stub_model(Status,
        :status_id => "Status",
        :name => "Name",
        :screen_name => "Screen Name",
        :url => "Url",
        :source => "Source",
        :via => "Via"
      ),
      stub_model(Status,
        :status_id => "Status",
        :name => "Name",
        :screen_name => "Screen Name",
        :url => "Url",
        :source => "Source",
        :via => "Via"
      )
    ])
  end

  it "renders a list of statuses" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Screen Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Via".to_s, :count => 2
  end
end
