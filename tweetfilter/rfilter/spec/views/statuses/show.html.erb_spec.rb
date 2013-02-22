require 'spec_helper'

describe "statuses/show.html.erb" do
  before(:each) do
    @status = assign(:status, stub_model(Status,
      :status_id => "Status",
      :name => "Name",
      :screen_name => "Screen Name",
      :url => "Url",
      :source => "Source",
      :via => "Via"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Status/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Screen Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Url/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Source/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Via/)
  end
end
