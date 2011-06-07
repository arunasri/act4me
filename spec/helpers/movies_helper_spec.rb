require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

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
