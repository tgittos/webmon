FactoryGirl.define do
  factory :site_health do
    http_response 200
    response_time 200
    association :site, factory: :site
  end
end
