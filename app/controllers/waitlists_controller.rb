class WaitlistsController < ApplicationController
  before_action :set_waitlist, only: %i[ show edit update destroy ]

  # GET /waitlists or /waitlists.json
  def index
    @waitlists = Waitlist.all
    @student_id = get_current_student_id
    @student_waitlists = Waitlist.where(:student_id => @student_id)
  end

  # GET /waitlists/1 or /waitlists/1.json
  def show
  end

  # GET /waitlists/new
  def new
    @waitlist = Waitlist.new
    if @course.nil?
      @course = Course.find(params[:course_id])
    end
    @student_id = get_current_student_id
  end

  # GET /waitlists/1/edit
  def edit
  end

  # POST /waitlists or /waitlists.json
  def create
    @waitlist = Waitlist.new(waitlist_params)

    # if course is already enrolled, restriction to join waitlist.
    if get_enrollment.exists?
      redirect_to enrolls_path, notice: "Error adding to Waitlist. Enrollment already exists"
      return false
    end

    respond_to do |format|
      if @waitlist.save
        format.html { redirect_to waitlists_path, notice: "Waitlist was successfully created." }
        format.json { render :show, status: :created, location: @waitlist }
        update_waitlist_capacity_on_create
      else
        format.html { redirect_to waitlists_path, notice: "Error adding to Waitlist.Waitlist already exists"  }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @waitlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /waitlists/1 or /waitlists/1.json
  def update
    respond_to do |format|
      if @waitlist.update(waitlist_params)
        format.html { redirect_to waitlist_url(@waitlist), notice: "Waitlist was successfully updated." }
        format.json { render :show, status: :ok, location: @waitlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @waitlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /waitlists/1 or /waitlists/1.json
  def destroy
    course_id = @waitlist.course_id
    @waitlist.destroy
    update_waitlist_capacity_on_destroy(course_id)

    respond_to do |format|
      format.html { redirect_to waitlists_url, notice: "You are removed from the Waitlist." }
      format.json { head :no_content }
    end
  end

  # retrives logged in student id
  def get_current_student_id
    @student_id =  Student.where(:email => current_user.email).pluck(:id)
    return @student_id
  end

  # updates waitlist capacity when a student joins the waitlist
  def update_waitlist_capacity_on_create
    @course = Course.find(params[:course_id])
    @course.Waitlist_Capacity = @course.Waitlist_Capacity - 1
    @course.save
  end

  # updates waitlist capacity when a student leaves the waitlist
  def update_waitlist_capacity_on_destroy(course_id)
    waitlist_capacity = Course.where(:id => course_id).pluck(:Waitlist_Capacity)
    waitlist_capacity = waitlist_capacity.first() + 1
    @course = Course.where(:id => course_id).update_all(Waitlist_Capacity: waitlist_capacity)
  end

  # fetches enrollment record of a student for a particular course
  def get_enrollment
    @course = Course.find(params[:course_id])
    @student_id = get_current_student_id
    @enrollment = Enroll.where(:student_id =>  @student_id).and(Enroll.where(:course_id => @course.id))
    return @enrollment
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_waitlist
      @waitlist = Waitlist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def waitlist_params
      params.require(:waitlist).permit(:student_id,:course_id)
    end
end
