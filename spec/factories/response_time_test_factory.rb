FactoryGirl.define do
  factory :response_time_test do
    comparison ResponseTimeTest.comparisons.first
    content 500
    failure_threshold 2
    clear_threshold 2
  end
end
