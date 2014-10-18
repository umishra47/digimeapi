class User < ActiveRecord::Base
	acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def send_reset_password_instructions_mail
    UserMailer.password_instruction_email(self).deliver
  end
end
