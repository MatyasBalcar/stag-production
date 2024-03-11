class UserTimetablesController < ApplicationController
    before_action :set_user_timetable, only: [:show, :edit, :update, :destroy]
  
    def index
      @user_timetables = UserTimetable.all
    end
  
    def show
    end
  
    def new
      @user_timetable = UserTimetable.new
    end
    def generate_signature(predmets_content, lectures_content)
      salt = "anlaki zkusili jste gg"
      data = predmets_content + lectures_content + salt
      Digest::SHA256.hexdigest(data )
    end
    def verify_signature(file, user)
      # Create a new Tempfile
      tempfile = Tempfile.new
      tempfile.binmode

      # Read the file from the tempfile attribute of the uploaded file
      tempfile.write(file.tempfile.read)
      tempfile.rewind
        
      is_valid = false
    
      Zip::File.open(tempfile.path) do |zip_file|
        entries = zip_file.entries
    
        # Extract the signature
        signature_entry = entries.find { |entry| entry.name == 'signature.txt' }
        if signature_entry
          original_signature = signature_entry.get_input_stream.read
        else
          is_valid = false
        end
        
        # Regenerate the signature based on the contents of the CSV files
        predmets_entry = entries.find { |entry| entry.name.include?('predmets') }
        lectures_entry = entries.find { |entry| entry.name.include?('lectures') }

        regenerated_signature = generate_signature( predmets_entry.get_input_stream.read,lectures_entry.get_input_stream.read)
 
        # Verify the signature
        if regenerated_signature.strip == original_signature.strip
          is_valid = true
        else

          is_valid = false
        end
      end
    
      tempfile.close
      tempfile.unlink
    
      is_valid
    end
    def create
      @user_timetable = UserTimetable.new(user_timetable_params)
      @user_timetable.user = current_user
      @user_timetable.name = "#{current_user.name}-rozvrh" if @user_timetable.name.blank?

    
      if params[:user_timetable][:data_file]
        Zip::File.open(params[:user_timetable][:data_file].path) do |zip_file|
          entries = zip_file.entries
    
          predmets_entry = entries.find { |entry| entry.name.include?('predmets') }
          lectures_entry = entries.find { |entry| entry.name.include?('lectures') }
    
          if predmets_entry && lectures_entry
            # The uploaded file contains 'predmets' and 'lectures' files.
            # Continue with the signature verification...
            if verify_signature(params[:user_timetable][:data_file], current_user)
              flash[:notice] = "Signature is valid"
    
              # Attach the uploaded file to the @user_timetable
              @user_timetable.data_file.attach(params[:user_timetable][:data_file])
    
              if @user_timetable.save
                redirect_to user_timetables_path, notice: 'User timetable was successfully created.'
              else
                redirect_to root_path, notice: 'Neco se pojebalo :('
              end
            else
              redirect_to root_path, notice: 'NT ;)'
            end
          else
            # The uploaded file does not contain 'predmets' and/or 'lectures' files.
            redirect_to root_path, notice: 'Chybi predmety nebo hodiny.'
          end
        end
      else
        redirect_to root_path, notice: 'nahraj file pls dik :)'
      end
    end
    def import
      user_timetable = UserTimetable.find(params[:id])
      UserTimetable.import(user_timetable.data_file, current_user)
      redirect_to user_timetables_path, notice: 'Timetable was successfully imported.'
    end
    def destroy_all
      UserTimetable.delete_all
      redirect_to user_timetables_path, notice: 'All your timetables have been deleted.'
    end
    def edit
    end
  
    def update
      if @user_timetable.update(user_timetable_params)
        redirect_to @user_timetable, notice: 'Timetable was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @user_timetable.destroy
      redirect_to user_timetables_url, notice: 'Timetable was successfully destroyed.'
    end
    def user_timetables
        @user_timetables = UserTimetable.all
      end
    private
      def set_user_timetable
        @user_timetable = UserTimetable.find(params[:id])
      end
  
      def user_timetable_params
        params.require(:user_timetable).permit(:name, :data_file)
      end
  end