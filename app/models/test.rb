class Test < ActiveRecord::Base
  
  belongs_to :site
  has_many :test_results, dependent: :destroy
  has_many :incident_tests, dependent: :destroy
  has_many :incidents, through: :incident_tests
  
  validates :comparison, presence: true
  validates :content, presence: true
  validates :content, uniqueness: { scope: :comparison }
  validate :email_thresholds 
  
  after_create :check!
  
  scope :active, ->{ where(active: true) }

  def self.types
    [{ label: "Response test", value: ResponseTest.class.name },
     { label: "Response time test", value: ResponseTimeTest.class.name },
     { label: "Content test", value: ContentTest.class.name }]
  end

  def self.comparisons
    raise "comparisons should be implemented in a sub-class"
  end

  def check!
    raise "check! should be implemented in a sub-class"
  end
 
  private

  def email_thresholds
    if (failure_threshold || 0) <= 0
      errors.add(:failure_threshold, 'cannot be less than 1')
    end
    if (clear_threshold || 0) <= 0
      errors.add(:clear_threshold, 'cannot be less than 1')
    end 
  end

end
