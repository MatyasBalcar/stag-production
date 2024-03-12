require 'zip'

class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[ show edit update destroy ]


  # GET /lectures or /lectures.json
# in app/controllers/lectures_controller.rb
  def index
    @lectures = Lecture.joins(predmet: :user).where(users: { id: current_user.id })
  end
  def export
    @lectures = Lecture.joins(predmet: :user).where(users: { id: current_user.id })
  
    respond_to do |format|
      format.csv { send_data @lectures.to_csv, filename: "lectures-#{current_user.name}.csv" }
    end
  end
  def import
    Lecture.import(params[:file], current_user)
    redirect_to root_url, notice: "Lectures imported."
  end
  def generate_signature(predmets_content, lectures_content)
    salt = "anlaki zkusili jste gg"
    data = predmets_content + lectures_content +salt

    Digest::SHA256.hexdigest(data )
  end
  def export_all
    # Generate both CSV files
    lectures_csv = Lecture.to_csv
    predmets_csv = Predmet.to_csv
    # Generate a signature
    signature = generate_signature( predmets_csv, lectures_csv)
  
    # Create a Zip file
    Zip::File.open('exports.zip', Zip::File::CREATE) do |zipfile|
      zipfile.get_output_stream('lectures.csv') { |f| f.puts lectures_csv }
      zipfile.get_output_stream('predmets.csv') { |f| f.puts predmets_csv }
      zipfile.get_output_stream('signature.txt') { |f| f.puts signature }
    end
  
    # Send the Zip file
    send_file 'exports.zip', type: 'application/zip'
  end
  # GET /lectures/1 or /lectures/1.json
  def show
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new
  end

  # GET /lectures/1/edit
  def edit
  end

  # POST /lectures or /lectures.json
  # def create
  #   @lecture = Lecture.new(lecture_params)

  #   respond_to do |format|
  #     if @lecture.save
  #       format.html { redirect_to root_path, notice: "Lecture was successfully created." }
  #       format.json { render :show, status: :created, location: @lecture }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @lecture.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def create
    @lecture = current_user.lectures.build(lecture_params)
    predmet = Predmet.find_by(name: @lecture.predmet_name)
    if predmet
      @lecture.color = predmet.color
    end
  
    if @lecture.save
      redirect_to @lecture, notice: 'Lecture was successfully created.'
    else
      render :new
    end
  end
  # PATCH/PUT /lectures/1 or /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to lecture_url(@lecture), notice: "Lecture was successfully updated." }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end
  def toggle_check
    @lecture = Lecture.find(params[:id])
    @lecture.update(is_checked: !@lecture.is_checked)
    redirect_to timetable_index_path
  end

  # DELETE /lectures/1 or /lectures/1.json
  def destroy
    @lecture.destroy!

    respond_to do |format|
      format.html { redirect_to lectures_url, notice: "Lecture was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def increase_start_time
    lecture = Lecture.find(params[:id])
    lecture.start_time += 15.minutes
    lecture.save
    redirect_to timetable_index_path
  end
  
  def decrease_start_time
    lecture = Lecture.find(params[:id])
    lecture.start_time -= 15.minutes
    lecture.save
    redirect_to timetable_index_path
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lecture_params
      params.fetch(:lecture, {}).permit(:predmet_name,:room, :teacher, :start_time, :end_time, :day, :length, :lecture_type, :is_stacked, :is_checked,:color)
    end

end
