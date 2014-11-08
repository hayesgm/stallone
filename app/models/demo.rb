# Represents a Demo Signup
#
# first_name:: 
# last_name:: 
# company:: 
# email::
# employees:: 
# interest:: 
class Demo < ActiveRecord::Base

  # Validations
  validates :first_name, :last_name, presence: true
  validates :company, presence: true
  validates :email, presence: true
  validates :employees, presence: true

  after_create { |demo| DemoMailer.new_demo(demo).deliver }
  
end
