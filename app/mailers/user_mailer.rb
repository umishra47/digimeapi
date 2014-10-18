class UserMailer < ActionMailer::Base

default_url_options[:host] = "localhost:3000"

def password_instruction_email(user)
  @user = user
  begin
    mail(:to => user.email, :subject => "Password Reset Instruction")
  end
end
end