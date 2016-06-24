class ArchivesController < ApplicationController
  before_action :set_archive, only: [:show, :edit, :update, :destroy]

  # GET /archives
  # GET /archives.json
  def index
    @archives = Archive.all
  end

  # GET /archives/1
  # GET /archives/1.json
  def show
  end

  # GET /archives/new
  def new
    @archive = Archive.new
 if params[:folder_id] #if we want to upload a file inside another folder
  @current_folder = Folder.all.find(params[:folder_id])
  @archive.folder_id = @current_folder.id
 end
  end

  # GET /archives/1/edit
  def edit
  end

  # POST /archives
  # POST /archives.json
  def create
    @archive = Archive.new(archive_params)

    if @archive.save
     flash[:notice] = "Successfully uploaded the file."

     if @archive.folder #checking if we have a parent folder for this file
       redirect_to browse_path(@archive.folder)  #then we redirect to the parent folder
     else
       redirect_to root_url
     end
    else
     render :action => 'new'
    end
  end

  # PATCH/PUT /archives/1
  # PATCH/PUT /archives/1.json
  def update
    respond_to do |format|
      if @archive.update(archive_params)
        format.html { redirect_to @archive, notice: 'Archive was successfully updated.' }
        format.json { render :show, status: :ok, location: @archive }
      else
        format.html { render :edit }
        format.json { render json: @archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archives/1
  # DELETE /archives/1.json
  def destroy
    arquivo = @archive
    @archive.destroy
      if arquivo.folder
      redirect_to browse_path(arquivo.folder)
    else
      redirect_to root_url
    end
  end
  def get
    archive = Archive.all.find_by_id(params[:id])
  if current_user
       send_file archive.uploaded_file.path, :type => archive.uploaded_file_content_type
  end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_archive
      @archive = Archive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def archive_params
      params.require(:archive).permit(:user_id, :uploaded_file, :folder_id)
    end
end
