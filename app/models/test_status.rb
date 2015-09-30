class TestStatus < ActiveRecord::Base
  belongs_to :content_test
  
  scope :latest, ->{ order('created_at DESC').first }
end
