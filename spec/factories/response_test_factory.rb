FactoryGirl.define do
  factory :response_test do
    comparison ResponseTest.comparisons.first
    content 200
    failure_threshold 2
    clear_threshold 2
  end
end
