class TestResult < ActiveRecord::Base
  belongs_to :test
  
  scope :newest_first, -> { order('created_at DESC') }
  scope :latest, ->{ newest_first.first }

end
