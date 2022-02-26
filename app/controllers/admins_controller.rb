class AdminsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_admin, only: %i[ show edit update destroy ]

  # GET /admins or /admins.json
  def index
    @admin = Admin.where(:email => current_user.email)[0]
  end

  # GET /admins/1 or /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
    @edit = false
  end

  # GET /admins/1/edit
  def edit
    @edit = true
  end

  # POST /admins or /admins.json
  def create
    @admin = Admin.new(admin_params)
    user_params = { "user_type" => "admin", "email" => admin_params["email"],
                    "password" => admin_params["password"],
                    "password_confirmation" => admin_params["password_confirmation"]}
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save and @admin.save
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully created." }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1 or /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully updated." }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1 or /admins/1.json
  def destroy
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to admins_url, notice: "Admin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:Name, :Phone_Number, :email, :password, :password_confirmation)
    end
end
