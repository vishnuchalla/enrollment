class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
    @yourcourses = Course.where(instructoremail: current_user.email)
    # if current_user.user_type == "instructor"
    #   e = Enroll.where(course_id: params[:course_id], student_id: params[:student_id]).pluck(:id)
    #   Enroll.delete(e)
    # end
  end

  def enrolled
    @students = Enroll.where(course_id:@course.id)
  end

  # GET /courses/1 or /courses/1.json
  def show
    @students = Enroll.where(course_id:@course.id)
    # if current_user.user_type == "instructor"
    #   e = Enroll.where(course_id: params[:course_id], student_id: params[:student_id]).pluck(:id)
    #   Enroll.delete(e)
    # end
    
  end

  # GET /courses/new
  def new
    @course = Course.new
    inst = Instructor.where(email: current_user.email).pluck(:name)
    @instname = inst[0]
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    @course.Instructor_Name = Instructor.where(email: current_user.email).pluck(:name)[0]
    @course.instructoremail = current_user.email
    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    if @course.Capacity > 0
      @course.Status = "OPEN"
      @course.save
    elsif @course.Waitlist_Capacity > 0
      @course.Status = "WAITLIST"
      @course.save
    else
      @course.Status = "CLOSED"
      @course.save
    end

    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    if current_user.user_type == "instructor"
      e = Enroll.where(course_id: @course.id).pluck(:id)
      for i in e
        Enroll.delete(i)
      end
    end
    @course.destroy

    respond_to do |format|
      if current_user.user_type.eql?("admin")
        format.html { redirect_to root_url, notice: "Course was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:Name, :Description, :Instructor_Name, :instructoremail, :Weekday1, :Weekday2, :Start_Time, :End_Time, :Course_Code, :Capacity, :Waitlist_Capacity, :Room, :Status)
    end
end
