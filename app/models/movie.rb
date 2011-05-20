class Movie < ActiveRecord::Base

  mount_uploader :vertical,   VerticalUploader
  mount_uploader :horizontal, HorizontalUploader

  validates :name, :presence => true

  validates :cast, :presence => true

  has_many :tweets, :dependent => :destroy, :inverse_of => :movie

  has_many :keywords, :dependent => :destroy do
    def query_twitter
      collect(&:perform_search).reduce(0, :+)
    end
  end

  default_scope :order => "movies.released_on desc"

  scope :spotlight,   :limit => 5
  scope :active, where(:disabled => false)
  scope :this_month,   lambda { where(:released_on => (1.month.ago)..Time.now) }
  scope :this_weekend, lambda { where(:released_on => (Time.now.beginning_of_week)..(Time.now.end_of_week)) }
  scope :last_weekend, lambda { where(:released_on => (1.week.ago.beginning_of_week)..(1.week.ago.end_of_week)) }

  accepts_nested_attributes_for :tweets, :allow_destroy => true

  def formatted_score
    "#{computed_score}%" rescue "N/A"
  end

  def computed_score
    return 0 if tweets.assesed.count == 0
    (((tweets.positive.count + (tweets.mixed.count * 0.5)) * 100.0)/ tweets.assesed.count).to_i
  end

  def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end
end
