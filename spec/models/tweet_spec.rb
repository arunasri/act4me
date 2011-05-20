require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tweet  do

  subject { @tweet = Factory(:tweet, :twitter_id => "123", :from_user => "jrntr") }

  context "instance methods" do
    its(:twitter_url) { should eql("http://twitter.com/jrntr/statuses/123") }
    it { should_not be_assesed }
  end

  context "not featured" do
    before(:each) { subject.update_attributes(:featured => false) }
    it { should_not be_featured }
  end

  context "not assesed" do
    before(:each) { subject.update_attributes(:category => 'fresh') }
    it { should_not be_assesed }
  end

  context "when featured" do
    before(:each) { subject.update_attributes(:featured => true) }
    it { should be_featured }
  end

  context "without url in text" do
    before(:each) { subject.update_attributes(:text => "welcome google com") }
    it { should_not be_url }
  end

  context "with url in text" do
    before(:each) { subject.update_attributes(:text => "welcome www.google.com") }
    it { should be_url }
  end

  context "callbacks" do
    it { should be_fresh }
  end

  context "#positive" do
    before(:each) { subject.positive! }
    it { should be_positive }
    it { should be_assesed }
    its(:mood) { should eql("positive.png") }
  end

  context "#terminate" do
    before(:each) { subject.terminate! }
    it { should be_terminate }
    it { should be_assesed }
    its(:mood) { should eql("terminate.png") }
  end

  context "#negative" do
    before(:each) { subject.negative! }
    it { should be_negative }
    it { should be_assesed }
    its(:mood) { should eql("negative.png") }
  end

  context "#mixed" do
    before(:each) { subject.mixed! }
    it { should be_mixed }
    it { should be_assesed }
    its(:mood) { should eql("mixed.png") }
  end
end

describe Tweet, "#scopes"  do
  before(:all) do
    @tweet1 = Factory(:negative, :featured => true)
    @tweet2 = Factory(:negative, :featured => false)
    @tweet3 = Factory(:mixed,    :featured => true)
    @tweet4 = Factory(:negative, :featured => false)
    @tweet5 = Factory(:positive, :featured => false)
  end

  it "list spotlight" do
    Tweet.spotlight.map(&:id).should =~ [ @tweet1.id, @tweet3.id ]
  end

  it "list negative" do
    Tweet.negative.map(&:id).should =~ [ @tweet1.id, @tweet2.id, @tweet4.id ]
  end

  it "list in positive" do
    Tweet.positive.map(&:id).should =~ [ @tweet5.id ]
  end

  it "list in mixed" do
    Tweet.mixed.map(&:id).should =~ [ @tweet3.id ]
  end
end

describe Tweet, "#validations"  do
  subject { @tweet = Factory(:tweet) }
  it { should belong_to(:movie) }
  it { should validate_uniqueness_of(:twitter_id).scoped_to(:movie_id) }
  it { should allow_value("welcome to rt wle").for(:text) }
  it { should allow_value("welcome to RTwle").for(:text) }
  it { should_not allow_value("welcome to RT wle").for(:text) }
end

describe Tweet, "#from_hashie" do
  subject { @tweet }
  before(:all) do
    @tweet = Tweet.from_hashie!(:created_at => "1/2/2009", :id => "234")
  end

  its(:created_on_twitter) { should equal_for_date("01/02/2009") }
  its(:twitter_id) { should eql(234) }
end
