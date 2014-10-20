class Users::PasswordsController < Devise::PasswordsController

# skip_before_filter  :verify_authenticity_token

	def create
		
				@user = User.send_reset_password_instructions(params[:user])
				# @user = User.send_reset_password_instructions_mail(params[:user])
		if successfully_sent?(@user)
			if request.content_type =~ /json/
				render :json =>{:message=> 'Confirmation message sent'}, :status => 200
			else
				render :xml =>{:message=> 'Confirmation message sent'}, :status => 200
			end
		else
			if request.content_type =~ /json/
				render :json =>{:message=> @user.errors},:status=> :unprocessable_entity
			else
				render :xml =>{:message=> @user.errors},:status=> :unprocessable_entity
			end
		end
	end

	def update
		
		self.resource = resource_class.reset_password_by_token(resource_params)
		if resource.errors.empty?
			if request.content_type =~ /json/
				render :json => {:message => 'Password updated successfully '},:status => 200
	 		else
				render :xml => {:message => 'Password updated successfully '},:status => 200
			end
		else
			if request.content_type =~ /json/
				render :json =>{:message=> resource.errors},:status=> :unprocessable_entity
			else
				render :xml =>{:message=> resource.errors},:status=> :unprocessable_entity
			end
		end
		puts params.to_yaml

	end

end