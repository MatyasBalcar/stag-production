class PredmetsController < ApplicationController
  before_action :set_predmet, only: %i[ show edit update destroy ]

  # GET /predmets or /predmets.json
# in app/controllers/predmets_controller.rb
  def index
    @predmets = current_user.predmets
  end

  # GET /predmets/1 or /predmets/1.json
  def show
  end

  # GET /predmets/new
  def new
    @predmet = Predmet.new
  end

  # GET /predmets/1/edit
  def edit
  end

  # POST /predmets or /predmets.json
  def create
    @predmet = current_user.predmets.new(predmet_params)
  
    respond_to do |format|
      if @predmet.save
        format.html { redirect_to root_path, notice: "Predmet was successfully created." }
        format.json { render :show, status: :created, location: @predmet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @predmet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /predmets/1 or /predmets/1.json
  def update
    respond_to do |format|
      if @predmet.update(predmet_params)
        format.html { redirect_to predmet_url(@predmet), notice: "Predmet was successfully updated." }
        format.json { render :show, status: :ok, location: @predmet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @predmet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /predmets/1 or /predmets/1.json
  def destroy
    @predmet.destroy!

    respond_to do |format|
      format.html { redirect_to predmets_url, notice: "Predmet was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def export
    @predmets = Predmet.joins(:user).where(users: { id: current_user.id })
  
    respond_to do |format|
      format.csv { send_data @predmets.to_csv, filename: "predmets-#{current_user.name}.csv" }
    end
  end
  def import
    Predmet.import(params[:file], current_user)
    redirect_to root_url, notice: "Classes imported."
  end
  def delete_all
    current_user.lectures.destroy_all
    current_user.predmets.destroy_all
    redirect_to root_path, notice: 'All your classes were successfully deleted.'
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_predmet
      @predmet = Predmet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def predmet_params
      params.fetch(:predmet, {}).permit(:name, :adbreviation, :status, :teacher, :color)
    end
end
