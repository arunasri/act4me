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
  subject { @tweet = Factory(:tweet, :twitter_id => "1234") }
  it { should belong_to(:movie) }
  it { should validate_uniqueness_of(:twitter_id).scoped_to(:movie_id) }
  it { should allow_value("welcome to rt wle").for(:text) }
  it { should allow_value("welcome to RTwle").for(:text) }
  it { should_not allow_value("welcome to RT wle").for(:text) }
  its("keyword.since_id") { should eql(1234) }
end

describe Tweet, "#from_hashie" do
  subject { @tweet }

  before(:all) do
    hash = {
      "created_at"=>"Thu, 19 May 2011 11:27:50 +0000",
      "profile_image_url"=>"http://a1.twimg.com/profile_images/1159027114/jpnewf_normal.JPG", "from_user_id_str"=>"119432610",
      "id_str"=>"71175222723739649",
      "from_user"=>"JalapathyG",
      "text"=>"Sharanya ante mee hero Komaram Puli lo talliga natincharu kada..aavida..senior actress",
      "to_user_id"=>59500008,
      "metadata"=>{"result_type"=>"recent"},
      "id"=>71175222723739649,
      "geo"=>nil,
      "to_user"=>"chintugupta",
      "from_user_id"=>119432610,
      "iso_language_code"=>"eo",
      "source"=>"&lt;a href=&quot;http://twitter.com/&quot;&gt;web&lt;/a&gt;",
      "to_user_id_str"=>"59500008"
    }

    @tweet = Tweet.from_hashie!(hash)
  end

  its(:created_on_twitter) { should equal_for_date("05/19/2011") }
  its(:twitter_id) { should eql(71175222723739649) }
  its(:from_user) { should eql("JalapathyG") }
  its(:text) { should eql("Sharanya ante mee hero Komaram Puli lo talliga natincharu kada..aavida..senior actress") }
end
