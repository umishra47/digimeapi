class UserMailer < ActionMailer::Base

# default_url_options[:host] = "localhost:3000"
default_url_options[:host] = "digimeapi.herokuapp.com"

def password_instruction_email(user)
  @user = user
  begin
    mail(:to => user.email, :subject => "Password Reset Instruction")
  end
end
end