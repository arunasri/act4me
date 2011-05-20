Factory.define :tweet do |p|
  p.association :movie
  p.association :keyword
  p.sequence(:twitter_id) { |n| n }
  p.sequence(:text) { |n| "#{Faker::Lorem.sentence} #{n}" }
end

Factory.define :positive, :parent => :tweet,:class => Tweet do |p|
  p.after_create { |t| t.positive! }
end

Factory.define :negative, :parent => :tweet,:class => Tweet do |p|
  p.after_create { |t| t.negative! }
end

Factory.define :mixed, :parent => :tweet,:class => Tweet do |p|
  p.after_create { |t| t.mixed! }
end
