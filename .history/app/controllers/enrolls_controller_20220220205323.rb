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

    @student_enrollments = Enroll.where(:student_id => s_id)
    @course_ids = @student_enrollments.pluck(:course_id)
    course_code_list = []
    @course_ids.each do |cid|
      course_code_list = Course.where(:id => cid ).pluck(:Course_Code)
    end
    @course_code = course_code_list
    s_id = Student.where(:email => current_user.email).pluck(:id)
    @s_id = s_id

    @student_enrollments = Enroll.where(:student_id => s_id)
    @course_ids = @student_enrollments.pluck(:course_id)
    course_code_list = []
    @course_ids.each do |cid|
      course_code_list = Course.where(:id => cid ).pluck(:Course_Code)
    end
    @course_code = course_code_list
  end

  # GET /enrolls/1 or /enrolls/1.json
  def show
  end

  # GET /enrolls/new
  def new
    
    if current_user.user_type == "instructor"
      capacity = Course.where(id: params[:course_id]).pluck(:Capacity)[0]
      wait = Course.where(id: params[:course_id]).pluck(:Waitlist_Capacity)[0]
      @course = Course.find(params[:course_id])
      if capacity > 0
        @course.Status = "OPEN"
        @course.save
        en = Enroll.new(:student_id => params[:student_id], :course_id => params[:course_id])
        en.save
        if en.save
          @course.Capacity = @course.Capacity - 1
          @course.save 
        end
      else 
        if wait > 0
          waitlist1 = Waitlist.new(:student_id => params[:student_id], :course_id => params[:course_id])
          waitlist1.save
          if waitlist1.save
            puts "---------------++++++++++++++-----------"
            @course.Waitlist_Capacity = @course.Waitlist_Capacity - 1
            @course.save
          else
            puts "---------------++++++++++++++-----------"

          end
      end
    end
     


  end

    

    @enroll = Enroll.new
    @student = Student.all      
    if @course.nil?
      @course = Course.find(params[:course_id])
    end
    s_id = Student.where(:email => current_user.email).pluck(:id)
    @s_id = s_id
  end

  # GET /enrolls/1/edit
  def edit
  end

  # POST /enrolls or /enrolls.json
  def create
    @enroll = Enroll.new(enroll_params)
    @student = Student.all
    respond_to do |format|
      if @enroll.save
        format.html { redirect_to enrolls_path, notice: "Enrollment was successfully created." }
        format.json { render :show, status: :created, location: @enroll }

        @course = Course.find(params[:course_id])
        @course.Capacity = @course.Capacity - 1
        @course.save

      else
        format.html { redirect_to enrolls_path, notice: "Error Creating Enrollment or Enrollment already exists"  }
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
    course_id = @enroll.course_id
    @enroll.destroy
    capacity = Course.where(:id => course_id).pluck(:Capacity)
    capacity = capacity.first() + 1
    @course = Course.where(:id => course_id).update_all(Capacity: capacity)

    respond_to do |format|
      format.html { redirect_to enrolls_url, notice: "Enrollment dropped successfully." }
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
