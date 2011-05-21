class Crawler

  attr_accessor :keyword

  attr_reader   :page

  delegate :since_id, :name, :movie, :to => :keyword

  def search
    @search ||= Twitter::Search.new
  end

  def initialize(keyword)
    self.keyword = keyword
  end

  def prepare_params
    search.clear
    search.per_page(100).containing(name).page(page)
    add_since_to_search
  end

  def add_since_to_search
    since_id ? search.since(since_id) : search.since_date(movie.released_on.to_s)
  end

  def perform_search
    @page = 1

    while true

      prepare_params
      search.fetch
      save_tweets

      break unless next_page?
    end
  end

  def next_page?
    search.next_page? && @page = @page + 1
  end

  def current_results
    search.fetch.results || []
  end

  def save_tweets
    current_results.map do | hashie |
      Tweet.from_hashie!(hashie).tap do | tweet |
        tweet.movie   = movie
        tweet.keyword = keyword
        tweet.save
      end
    end
  end
end
