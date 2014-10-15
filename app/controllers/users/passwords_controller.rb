class Users::PasswordsController < Devise::PasswordsController

	def create
		@user = User.send_reset_password_instructions(params[:user])
		if successfully_sent?(@user)
			render :xml =>{:message=> 'Confirmation message sent'}, :status => 200
		else
			render :xml =>{:message=> @user.errors},:status=> :unprocessable_entity
		end
	end

	def update
		self.resource = resource_class.reset_password_by_token(resource_params)
		if resource.errors.empty?
			render :xml => {:message => 'Password updated successfully '},:status => 200
		else
			render :xml =>{:message=> resource.errors},:status=> :unprocessable_entity
		end
	end

end