class RegistrationsController < Devise::RegistrationsController
skip_before_filter  :verify_authenticity_token

respond_to :json

def create
    
    
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        format.json { render json: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
end

private
        # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password)
    end

end