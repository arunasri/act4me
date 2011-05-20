require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Keyword, "#validations" do
  before(:each) { @keyword = Factory(:keyword) }
  it { should validate_uniqueness_of(:name).scoped_to(:movie_id) }
  it { should validate_presence_of(:name) }
end
