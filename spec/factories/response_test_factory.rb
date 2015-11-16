FactoryGirl.define do
  factory :response_test do
    comparison ResponseTest.comparisons.first
    content 200
  end
end
