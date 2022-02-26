class EnrollsController < ApplicationController
  before_action :set_enroll, only: %i[ show edit update destroy ]

  # GET /enrolls or /enrolls.json
  def index
    @enrolls = Enroll.all
    @student_id = get_current_student_id
    @student_enrollments = Enroll.where(:student_id => @student_id)
  end

  # GET /enrolls/1 or /enrolls/1.json
  def show
  end

  def studentenroll
    @enroll = Enroll.new
    if current_user.user_type != "student"
      capacity = Course.where(id: params[:course_id]).pluck(:Capacity)[0]
      wait = Course.where(id: params[:course_id]).pluck(:Waitlist_Capacity)[0]
      @course = Course.find(params[:course_id])
      if capacity > 0
        @course.Status = "OPEN"
        @course.save
        en = Enroll.new(:student_id => params[:student_id], :course_id => params[:course_id])
        en.save
        @eid = en.id
        if en.save
          @good = "true"
          @course.Capacity = @course.Capacity - 1
          @course.save
        else
          @good = "false"
        end
      else
        if wait > 0
          waitlist1 = Waitlist.new(:student_id => params[:student_id], :course_id => params[:course_id])
          waitlist1.save
          if waitlist1.save
            @course.Waitlist_Capacity = @course.Waitlist_Capacity - 1
            @course.save
            @good = "waitlisted"
          else
            @good = "failed"
          end
        end
      end
    end

  end

  # GET /enrolls/new
  def new
    if current_user.user_type != "student"
      capacity = Course.where(id: params[:course_id]).pluck(:Capacity)[0]
      wait = Course.where(id: params[:course_id]).pluck(:Waitlist_Capacity)[0]
      @course = Course.find(params[:course_id])
      if capacity > 0
        @course.Status = "OPEN"
        @course.save
        en = Enroll.new(:student_id => params[:student_id], :course_id => params[:course_id])
        en.save
        if en.save
          @good = "true"
          @course.Capacity = @course.Capacity - 1
          @course.save
        else
          # flash[:error] = "error adding student to waitlist"
          # redirect_to course_wait_path
        end
      else
        if wait > 0
          waitlist1 = Waitlist.new(:student_id => params[:student_id], :course_id => params[:course_id])
          waitlist1.save
          if waitlist1.save
            @course.Waitlist_Capacity = @course.Waitlist_Capacity - 1
            @course.save
          else
            flash[:error] = "error adding student to waitlist"
            #redirect_to course_wait_path(:course_id => params[:course_id])
          end
        end
      end
    end
    @stu_id = params[:a]
    @enroll = Enroll.new
    @student = Student.all
    if @course.nil?
      @course = Course.find(params[:course_id])
    end
    @student_id = get_current_student_id
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
        update_course_capacity_on_create
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
    enroll_waitlisted_students(course_id)

    respond_to do |format|
      format.html { redirect_to enrolls_url, notice: "Enrollment dropped successfully." }
      format.json { head :no_content }
    end
  end

  # retrives logged in student id

  def get_current_student_id
    @student_id =  Student.where(:email => current_user.email).pluck(:id)
    return @student_id
  end

  # updates course capacity when a student gets enrolled
  def update_course_capacity_on_create
    @course = Course.find(params[:course_id])
    @course.Capacity = @course.Capacity - 1
    @course.save
  end

  # automatically enrolls student from waitlist when vacancy is found
  def enroll_waitlisted_students(course_id)
    @waitlisted_student = Waitlist.where(:course_id => course_id).order("created_at ASC").pluck(:student_id)

    if @waitlisted_student.count != 0
      @student_id = @waitlisted_student.first()
      @enrollment = Enroll.create(student_id: @student_id, course_id: course_id)
      @enrollment.save
      @update_waitlist = Waitlist.where(:student_id => @student_id).and(Waitlist.where(:course_id => course_id )).pluck(:id)
      Waitlist.destroy(@update_waitlist)
      waitlist_capacity = Course.where(:id => course_id).pluck(:Waitlist_Capacity)
      waitlist_capacity = waitlist_capacity.first() + 1
      @course = Course.where(:id => course_id).update_all(Waitlist_Capacity: waitlist_capacity)

    else
      capacity = Course.where(:id => course_id).pluck(:Capacity)
      capacity = capacity.first() + 1
      @course = Course.where(:id => course_id).update_all(Capacity: capacity)
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