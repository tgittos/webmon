FactoryGirl.define do
  factory :content_test do
    comparison ContentTest.comparisons.first
    content "Foobar"
    failure_threshold 2
    clear_threshold 2
  end
end
