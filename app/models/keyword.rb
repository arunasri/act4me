class Keyword < ActiveRecord::Base

  belongs_to :movie

  validates :name, :presence => true, :uniqueness => { :scope => :movie_id }

  def search_instance
    @search ||= Twitter::Search.new
  end

  def prepare_params_for(page_number = 1)
    search_instance.clear
    search_instance.per_page(100).containing(name).page(page_number)
    add_since_to_search
  end

  def add_since_to_search
    if since_id
      search_instance.since(since_id)
    else
      search_instance.since_date(movie.released_on.to_s)
    end
  end

  def perform_search

    counter = 1

    while true

      output = prepare_params_for(counter).fetch

      create_tweets if output.results

      break unless search_instance.next_page?

      counter += 1
    end

    counter
  end

  def create_tweets
    transaction do

      to_tweets.each do | tweet |
        tweet.movie = movie

        if tweet.save
          self.since_id = tweet.twitter_id
        end
      end

      changed? && save
    end
  end

  def to_tweets
    search_instance.map { | hashie | Tweet.from_hashie!(hashie) }
  end
end
