class TestCase < ActiveRecord::Base
  belongs_to :problem

  validates_associated :problem
  validates_presence_of :problem, :message => "is invalid"
end
