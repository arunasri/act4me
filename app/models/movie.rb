class Movie < ActiveRecord::Base

  mount_uploader :vertical,   VerticalUploader
  mount_uploader :horizontal, HorizontalUploader

  validates :name, :presence => true

  validates :cast, :presence => true

  has_many :tweets, :dependent => :destroy, :inverse_of => :movie

  has_many :keywords, :dependent => :destroy

  default_scope :order => "movies.released_on desc"

  scope :spotlight,   :limit => 5
  scope :active, where(:disabled => false)
  scope :this_month,   lambda { where(:released_on => (1.month.ago)..Time.now) }
  scope :this_weekend, lambda { where(:released_on => (Time.now.beginning_of_week)..(Time.now.end_of_week)) }
  scope :last_weekend, lambda { where(:released_on => (1.week.ago.beginning_of_week)..(1.week.ago.end_of_week)) }
  accepts_nested_attributes_for :tweets, :allow_destroy => true

  def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end

  def sync
    keywords.each(&:perform_search)
    self.last_computed_score = computed_score rescue nil
    save
  end

  private

  def computed_score
    (((tweets.positive.count + (tweets.mixed.count * 0.5)) * 100.0)/ tweets.assesed.count).to_i
  end
end
