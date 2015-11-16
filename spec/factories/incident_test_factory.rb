FactoryGirl.define do
  factory :incident_test do
    association :incident, factory: :incident
    association :test, factory: :test
  end
end
