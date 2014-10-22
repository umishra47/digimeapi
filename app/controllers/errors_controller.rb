class ErrorsController < ApplicationController
  # def error404
  #   render status: :not_found
  # end

  def error_404
    @not_found_path = params[:not_found]
  end

  def error_500
  end
end