require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# Specs in this file have access to a helper object that includes
# the MoviesHelper. For example:
#
# describe MoviesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end

describe MoviesHelper do
  describe "movie with computed score" do
    subject { stub(:last_computed_score => 24) }
    it "report span with percent and span with % sign" do
      expected = "<span class=\"percentage\">24</span><span class=\"percentage-sign\">%</span>"
      helper.formatted_score(subject).should eql(expected)
    end
  end

  describe "movie without computed score" do
    subject { stub(:last_computed_score => nil) }
    it "report span with percent and span with % sign" do
      expected = "<span class=\"percentage\">N/A</span>"
      helper.formatted_score(subject).should eql(expected)
    end
  end
end
