FactoryGirl.define do
  factory :incident do
    association :site, factory: :site
  end
end
