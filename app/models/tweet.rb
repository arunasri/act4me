class RetweetValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.try(:=~,/ RT /)
      record.errors[attribute] << 'retweets can not be added'
    end
  end
end

class Tweet < ActiveRecord::Base

  belongs_to :movie, :inverse_of => :tweets

  serialize :metadata

  cattr_reader :per_page

  @@per_page = 10
  CATEGORIES = %w(positive negative mixed)


  scope :spotlight, where(:featured => true)

  after_create  :fresh!, :unless => :url?

  after_create  :external!, :if => :url?

  scope :assesed, where(:category => CATEGORIES)

  validates :twitter_id, :presence => true, :retweet => true, :uniqueness => { :scope => :movie_id }

  validates :text, :presence => true, :retweet => true, :uniqueness => { :scope => [:from_user, :movie_id] }


  def url
    ActionView::Helpers::TextHelper::AUTO_LINK_RE.match(text)[0]
  end

  def url?
    ActionView::Helpers::TextHelper::AUTO_LINK_RE.match(text).present?
  end

  def assesed?
    !fresh?
  end

  def not_featured?
    !featured?
  end

  def twitter_url
    "http://twitter.com/#{from_user}/statuses/#{twitter_id}"
  end

  def mood
    "#{category}.png"
  end

  class << self

    def only_related_attributes(hashie)
      hashie.to_hash.with_indifferent_access.slice(*columns.map(&:name))
    end

    def from_hashie!(h)
      h.stringify_keys!
      options = { :twitter_id => h.delete("id"), :created_on_twitter => h.delete("created_at") }

      new(options.merge(only_related_attributes(h)))
    end

    def create_bool_methods(*method_names)
      method_names.each do | method |
        class_eval <<-method_body

        scope :#{method}, where(:category => method.to_s)

        def #{method}!
          update_attribute(:category, '#{method}')
        end

        def #{method}?
          self.category == '#{method}'
        end

        method_body
      end
    end
  end

  create_bool_methods :fresh, :terminate, :positive, :negative, :mixed, :external
end
