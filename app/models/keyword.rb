class Keyword < ActiveRecord::Base

  belongs_to :movie
  has_many   :tweets, :inverse_of => :keyword

  validates :name, :presence => true, :uniqueness => { :scope => :movie_id }

  def perform_search
    Crawler.new(self).perform_search
  end
end
