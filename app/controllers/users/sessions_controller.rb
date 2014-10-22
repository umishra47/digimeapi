class Users::SessionsController < Devise::SessionsController
  # prepend_before_filter :require_no_authentication, only: [ :new, :create ]
  # prepend_before_filter :allow_params_authentication!, only: :create
  # prepend_before_filter :verify_signed_out_user, only: :destroy

  #prepend_before_filter only: [ :create, :destroy ] { request.env["devise.skip_timeout"] = true }

  before_filter :ensure_params_exist, :except => [:destroy]
  acts_as_token_authentication_handler_for User, :except=>[:create]
  # skip_before_filter  :verify_authenticity_token
  # respond_to :json , :xml
  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    # self.resource = warden.authenticate!(auth_options)
    # set_flash_message(:notice, :signed_in) if is_flashing_format?
    # sign_in(resource_name, resource)
    # yield resource if block_given?
    # respond_with resource, location: after_sign_in_path_for(resource)

    # resource = warden.authenticate!(:scope => resource_name, :store => !(request.format.xml?), :recall => "#{controller_path}#invalid_login_attempt")
  	# sign_in(resource_name, resource)
  	# render xml: {
    #  	:response => 'ok',
    #  	:user_email => current_user.email,
    #  	:user_token => current_user.authentication_token,
    #  	:id => current_user.id
  	#  } ,:status => 200
    resource = warden.authenticate!(:scope => resource_name, :store => !(request.format.json?) && !(request.format.xml?), :recall => "#{controller_path}#invalid_login_attempt")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_to do |format|
        format.json do
          render json: {
             :response => 'ok',
             :user_email => current_user.email,
             :user_token => current_user.authentication_token,
             :id => current_user.id
             }, :status => :ok
          return
        end
        format.xml do
          render xml: {
             :response => 'ok',
             :user_email => current_user.email,
             :user_token => current_user.authentication_token,
             :id => current_user.id
             }, :status => :ok
          return
        end
    end
  end

  def ensure_params_exist
      return unless params[:user].blank?
      if request.content_type =~ /json/
        render :json=>{:message=>"missing user login parameter"}, :status=>422
      else
        render :xml=>{:message=>"missing user login parameter"}, :status=>422
      end
  end

  def invalid_login_attempt
        render :json=> {:message=>"Error with your login or password..."}, :status=>401
        render :xml=> {:message=>"Error with your login or password..."}, :status=>401
  end

  # DELETE /resource/sign_out
  # def destroy
  #   signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  #   set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
  #   yield if block_given?
  #   respond_to_on_destroy
  # end

  # protected

  # def sign_in_params
  #   devise_parameter_sanitizer.sanitize(:sign_in)
  # end

  # def serialize_options(resource)
  #   methods = resource_class.authentication_keys.dup
  #   methods = methods.keys if methods.is_a?(Hash)
  #   methods << :password if resource.respond_to?(:password)
  #   { methods: methods, only: [:password] }
  # end

  # def auth_options
  #   { scope: resource_name, recall: "#{controller_path}#new" }
  # end

  # private

  # Check if there is no signed in user before doing the sign out.
  #
  # If there is no signed in user, it will set the flash message and redirect
  # to the after_sign_out path.
  # def verify_signed_out_user
  #   if all_signed_out?
  #     set_flash_message :notice, :already_signed_out if is_flashing_format?

  #     respond_to_on_destroy
  #   end
  # end

  # def all_signed_out?
  #   users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

  #   users.all?(&:blank?)
  # end

  # def respond_to_on_destroy
  #   # We actually need to hardcode this as Rails default responder doesn't
  #   # support returning empty response on GET request
  #   respond_to do |format|
  #     format.all { head :no_content }
  #     format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
  #   end
  # end
end