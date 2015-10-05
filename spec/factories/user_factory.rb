FactoryGirl.define do
  factory :user do
    sequence(:id)
    email "foo@bar.org"
    app_uid "123456789asdfgHJKL"
  end
end
