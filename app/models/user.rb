# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
     has_secure_password
  
  #before_save { self.email.downcase! } 
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  #describe "email address with mixed case" do
  #let(:mixed_case_email) { "Foo@ExamPle.COm" }
  
  #it "should be save as all lower-case" do
    #@user.email = mixed_case_email
    #@user.save
    #@user.reload.email.should = mixed_case_email.downcase
  #end
  #end  
    validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true
    
   private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
