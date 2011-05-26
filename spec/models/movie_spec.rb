require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Movie do
  subject { Factory(:movie) }

  context "with last_score" do
    before(:each) { subject.should_receive(:computed_score).and_return(24) }
    its(:formatted_score) { should eql("24") }
  end

  context "with last_score" do
    before(:each) { subject.should_receive(:computed_score).and_return(nil) }
    its(:formatted_score) { should eql("N/A") }
  end
end

describe Movie, "#last_computed_score" do

  subject { Factory(:movie) }

  context "with no assesed tweets" do
    before(:each) { Factory(:tweet, :movie => subject) }
    its(:last_computed_score) { should nil }
  end

  context "when you add positive tweet to movie" do
    before(:each) do
      tweet = Factory(:tweet, :movie => subject)
      subject.reload

      subject.tweets_attributes = [ { :id => tweet.id, :category => 'positive' } ]
      subject.save
      subject.formatted_score
    end
    its(:last_computed_score) { should eql(100) }
  end

  context "when you add two positive tweets and negative tweet and mixed tweet to movie" do
    before(:each) do
      t1 = Factory(:tweet, :movie => subject)
      t2 = Factory(:tweet, :movie => subject)
      t3 = Factory(:tweet, :movie => subject)
      t4 = Factory(:tweet, :movie => subject)
      subject.reload

      subject.tweets_attributes = [ { :id => t1.id, :category => 'positive' },{ :id => t2.id, :category => 'negative' }, { :id => t3.id, :category => 'positive' }, { :id => t4.id, :category => 'mixed' } ]
      subject.save
      subject.formatted_score
    end
    its(:last_computed_score) { should eql(62) }
  end
end

describe Movie, "#validations" do
  subject { Factory(:movie) }
  it { should have_many(:tweets).dependent(:destroy) }
  it { should have_many(:keywords).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cast) }
end

describe Movie, "#scopes" do
  before(:all) do
    @movie1 = Factory(:movie, :released_on => "5/12/2011", :disabled => true)
    @movie2 = Factory(:movie, :released_on => "5/17/2011", :disabled => true)
    @movie3 = Factory(:movie, :released_on => "5/16/2011", :disabled => false)
    @movie4 = Factory(:movie, :released_on => "5/20/2011", :disabled => true)
    @movie5 = Factory(:movie, :released_on => "5/09/2010", :disabled => false)
    @movie6 = Factory(:movie, :released_on => "5/21/2011", :disabled => true)
  end

  around(:each) { |example| Timecop.freeze(Time.local(2011, 5, 21, 12, 0, 0), &example) }

  it "actively tracking movies" do
    Movie.active.map(&:id).should =~ [ @movie3.id, @movie5.id ]
  end

  it "released this weekend" do
    Movie.last_weekend.map(&:id).should =~ [ @movie1.id ]
  end

  it "released last week" do
    Movie.this_weekend.map(&:id).should =~ [@movie2.id, @movie4.id, @movie6.id]
  end

  it "released this month" do
    Movie.this_month.map(&:id).should =~ [ @movie1.id, @movie2.id, @movie3.id, @movie4.id, @movie6.id]
  end
end
