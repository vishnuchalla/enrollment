class InstructorsController < UsersController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_instructor, only: %i[ show edit update destroy ]

  # GET /instructors or /instructors.json
  def index
    @instructors = Instructor.all
  end

  # GET /instructors/1 or /instructors/1.json
  def show
  end

  # GET /instructors/new
  def new
    @instructor = Instructor.new
    @edit = false
  end

  # GET /instructors/1/edit
  def edit
    @edit = true
  end

  # POST /instructors or /instructors.json
  def create
    @edit = false
    @instructor = Instructor.new(instructor_params)
    user_params = { "user_type" => "instructor", "email" => instructor_params["email"],
                    "password" => instructor_params["password"],
                    "password_confirmation" => instructor_params["password_confirmation"]}
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save && @instructor.save
        format.html { redirect_to instructor_url(@instructor), notice: "Instructor was successfully created." }
        format.json { render :show, status: :created, location: @instructor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructors/1 or /instructors/1.json
  def update
    @user = User.where(:email => instructor_params[:email])[0]
    us = UsersController.new
    user_params = { "user_type" => "instructor", "email" => 'harinibharata@gmail.com',
                    "password" => instructor_params["password"],
                    "password_confirmation" => instructor_params["password_confirmation"]}
    respond_to do |format|
      if super.@user.update(user_params)  && @instructor.update(instructor_params)
        format.html { redirect_to instructor_url(@instructor), notice: "Instructor was successfully updated." }
        format.json { render :show, status: :ok, location: @instructor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instructors/1 or /instructors/1.json
  def destroy
    @user = User.where(:email => @instructor[:email])[0]
    @user.destroy
    @instructor.destroy

    respond_to do |format|
      if current_user.user_type.eql?("admin")
        format.html { redirect_to root_url, notice: "Instructor was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to instructors_url, notice: "Instructor was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def instructor_params
      params.require(:instructor).permit(:Name, :Department, :email, :password, :password_confirmation)
    end
   
end
