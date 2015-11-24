class Test < ActiveRecord::Base
  
  belongs_to :site
  has_many :test_results, dependent: :destroy
  has_many :incident_tests, dependent: :destroy
  has_many :incidents, through: :incident_tests
  
  validates :comparison, presence: true
  validates :content, presence: true
  validates :failure_threshold, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :clear_threshold, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  
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

end
