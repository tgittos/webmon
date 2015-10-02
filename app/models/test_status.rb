class TestStatus < ActiveRecord::Base
  belongs_to :content_test
  
  scope :newest_first, -> { order('created_at DESC') }
  scope :latest, ->{ newest_first.first }

  def css_class
    result ? "ok" : "error";
  end
end
