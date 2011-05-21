require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Crawler do
  context "when since id absent" do
    subject { @crawler.search.query }
    before(:each) do
      @movie   = Factory(:movie, :released_on => "12/2/2009")
      @keyword = Factory(:keyword, :name => "titanic", :movie => @movie)
      @crawler = Crawler.new(@keyword)
      @crawler.add_since_to_search
    end
    its([:since]) { should eql("2009-12-02") }
    its([:since_id]) { should be_nil }
  end

  context "when since id absent" do
    subject { @crawler.search.query }
    before(:each) do
      @keyword = Factory(:keyword, :name => "titanic", :since_id => "1234")
      @crawler = Crawler.new(@keyword)

      @crawler.add_since_to_search
    end
    its([:since]) { should be_nil }
    its([:since_id]) { should eql("1234") }
  end

  context "prepare parameters" do
    subject { @crawler.search.query }
    before(:each) do
      @keyword = Factory(:keyword, :name => "titanic", :since_id => "1234")
      @crawler = Crawler.new(@keyword)
    end

    context "for page number 2" do
      before(:each) do
        @crawler.instance_eval { @page = 2 }
        @crawler.prepare_params
      end
      its([:q]) { should =~ ['titanic'] }
      its([:page]) { should eql(2) }
      its([:since]) { should be_nil }
      its([:since_id]) { should eql("1234") }
    end

    context "for page number 1" do
      before(:each) do
        @crawler.instance_eval { @page = 1 }
        @crawler.prepare_params
      end
      its([:q]) { should =~ ['titanic'] }
      its([:page]) { should eql(1) }
      its([:since]) { should be_nil }
      its([:since_id]) { should eql("1234") }
    end
  end

  context "instance methods" do
    before(:each) do
      @keyword = Factory(:keyword, :name => "titanic", :since_id => "1234")
      @crawler = Crawler.new(@keyword)
    end

    context "#next" do
      before(:each) { @crawler.instance_eval { @page = 10 } }

      it "be next page if search instance returns next page true" do
        @crawler.search.should_receive(:next_page?).and_return(true)
        @crawler.next_page?.should eql(11)
      end

      it "be nil if search instance returns no next page" do
        @crawler.search.should_receive(:next_page?).and_return(false)

        @crawler.should_not be_next_page
      end
    end
  end
end


describe Tweet do
  before(:each) do
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
    @keyword = Factory(:keyword, :name => "titanic")
    @crawler = Crawler.new(@keyword)

    @crawler.should_receive(:current_results).and_return([hash])
    @crawler.save_tweets
  end

  subject { @keyword.tweets.last }
  its(:created_on_twitter) { should equal_for_date("05/19/2011") }
  its(:twitter_id) { should eql(71175222723739649) }
  its(:from_user) { should eql("JalapathyG") }
  its(:keyword_id) { should eql(@keyword.id) }
  its(:movie_id) { should eql(@keyword.movie.id) }
  its(:text) { should eql("Sharanya ante mee hero Komaram Puli lo talliga natincharu kada..aavida..senior actress") }
end
