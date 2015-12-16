class TestResult < ActiveRecord::Base
  belongs_to :test
  
  scope :newest_first, -> { order('created_at DESC') }
  scope :latest, ->{ newest_first.first }

  TEST_FAILED_REASON = "test_failed"
  TEST_ERRORED_REASON = "error"

end
