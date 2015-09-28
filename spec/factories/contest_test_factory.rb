FactoryGirl.define do
  factory :content_test do
    comparison ContentTest.comparisons.first
    content "Foobar"
  end
end
