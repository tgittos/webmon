FactoryGirl.define do
  factory :response_time_test do
    comparison ResponseTimeTest.comparisons.first
    content 500
  end
end
