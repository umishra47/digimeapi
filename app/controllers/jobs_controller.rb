class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
    respond_to do |format|
      if request.content_type =~ /json/
        format.json { render json: @jobs }
      else
        format.xml { render xml: @jobs }
      end
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    respond_to do |format|
      puts "******************"
      puts"1111111111111111111"
      puts params.to_yaml
      puts "******************"

      if @job.save
        if request.content_type =~ /json/
          format.json { render json: @job }
        else
          format.xml { render xml: @job }
        end
      else
        if request.content_type =~ /json/
          format.json { render json: @job.errors, status: :unprocessable_entity }
        else
          format.xml { render xml: @job.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        if request.content_type =~ /json/
          format.json { render json: @job }
        else
          format.xml { render xml: @job }
        end
      else
        if request.content_type =~ /json/
          format.json { render json: @job.errors, status: :unprocessable_entity }
        else
          format.xml { render xml: @job.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy  
   
    @job = Job.find(params[:id])
    
    respond_to do |format|
      if @job.destroy
        if request.content_type =~ /json/
          format.json { render json: "Successfully Deleted", status: :ok }
        else
          format.xml { render xml: "Successfully Deleted", status: :ok }
        end
      else
        if request.content_type =~ /json/
          format.json { render json: @job.errors, status: :unprocessable_entity }
        else
          format.xml { render xml: @job.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :location, :description)
    end
end
