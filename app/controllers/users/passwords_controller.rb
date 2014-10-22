class Users::PasswordsController < Devise::PasswordsController

# respond_to :json , :xml

	def create
		
		@user = User.send_reset_password_instructions(params[:user])
    	respond_to do |format|
    		
			if successfully_sent?(@user)
				format.json{render :json =>{:message=> 'Confirmation message sent'}, :status => 200}
				format.xml{render :xml =>{:message=> 'Confirmation message sent'}, :status => 200}
			else
				format.json{render :json =>{:message=> @user.errors},:status=> :unprocessable_entity}
				format.xml{render :xml =>{:message=> @user.errors},:status=> :unprocessable_entity}
			end
		end
	end

	def update
		
		self.resource = resource_class.reset_password_by_token(resource_params)
    	respond_to do |format|
			if resource.errors.empty?
				format.json{render :json => {:message => 'Password updated successfully '},:status => 200}
				format.xml{render :xml => {:message => 'Password updated successfully '},:status => 200}
			else
				format.json{render :json =>{:message=> resource.errors},:status=> :unprocessable_entity}
				format.xml{render :xml =>{:message=> resource.errors},:status=> :unprocessable_entity}
			end
		end
	end

end