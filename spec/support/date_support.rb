RSpec::Matchers.define :equal_for_date do |expected|
  match do |actual|
    actual.strftime("%m/%d/%Y") == expected
  end
end
