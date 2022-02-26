class StudentsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @students = Student.all
    if current_user.user_type == "instructor"
      @students = Enroll.where(course_id:params[:course_id])
      @cid = params[:course_id]
      e = Enroll.where(course_id: params[:course_id], student_id: params[:student_id]).pluck(:id)
      Enroll.delete(e)
      @course = Course.find(params[:course_id])
      if @course.Capacity == 0 and @course.Waitlist_Capacity>0
        @course.Waitlist_Capacity = @course.Waitlist_Capacity - 1
      else
        @course.Capacity = @course.Capacity - 1
        @course.save
      end
      
    end

  end

  # GET /students/1 or /students/1.json
  def show
    
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)
    user_params = { "user_type" => "student", "email" => student_params["email"],
                    "password" => student_params["password"],
                    "password_confirmation" => student_params["password_confirmation"]}
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save && @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    @user = User.where(:email => student_params[:email])[0]
    user_params = { "user_type" => "student", "email" => student_params["email"],
                    "password" => student_params["password"],
                    "password_confirmation" => student_params["password_confirmation"]}
    respond_to do |format|
      if @user.update(user_params) && @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @user = User.where(:email => @student[:email])[0]
    @user.destroy
    @student.destroy

    respond_to do |format|
      if current_user.user_type.eql?("admin")
        format.html { redirect_to root_url, notice: "Student was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:Name, :date_of_birth, :Phone_Number, :Major, :Student_ID, :email, :password, :password_confirmation)
    end
end
