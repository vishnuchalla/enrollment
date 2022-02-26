class EnrollsController < ApplicationController
  before_action :set_enroll, only: %i[ show edit update destroy ]

  # GET /enrolls or /enrolls.json
  def index
    @enrolls = Enroll.all
    student_list = Student.where(:email => current_user.email).pluck(:id)
    s_id = 0
    student_list.each do |id|
      if id == current_user.id
        s_id = id
        break
      end
    end

    @student_enrollments = Enroll.where(:student_id => s_id) #
    @s_id = s_id
  end

  # GET /enrolls/1 or /enrolls/1.json
  def show
  end

  # GET /enrolls/new
  def new
    @enroll = Enroll.new
    @student = Student.where(true)
    if @course.nil?
      @course = Course.find(params[:course_id])
    end
    student_list = Student.where(:email => current_user.email).pluck(:id)
    student_list.each do |id|
      if id == current_user.id
        @s_id = id
      end
    end
  end

  # GET /enrolls/1/edit
  def edit
  end

  # POST /enrolls or /enrolls.json
  def create
    @enroll = Enroll.new(enroll_params)

    respond_to do |format|
      if @enroll.save
        format.html { redirect_to enroll_url(@enroll), notice: "Enrollment was successfully created." }
        format.json { render :show, status: :created, location: @enroll }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @enroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrolls/1 or /enrolls/1.json
  def update
    respond_to do |format|
      if @enroll.update(enroll_params)
        format.html { redirect_to enroll_url(@enroll), notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enroll }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrolls/1 or /enrolls/1.json
  def destroy
    @enroll.destroy

    respond_to do |format|
      format.html { redirect_to enrolls_url, notice: "Enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enroll
      @enroll = Enroll.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enroll_params
      params.require(:enroll).permit(:student_id,:course_id)
    end
end
