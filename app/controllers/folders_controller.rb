class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  # GET /folders
  # GET /folders.json
  def index
    @folders = Folder.all
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
  end

  # GET /folders/new
  def new
    @folder = Folder.new
   #if there is "folder_id" param, we know that we are under a folder, thus, we will essentially create a subfolder
   if params[:folder_id] #if we want to create a folder inside another folder

     #we still need to set the @current_folder to make the buttons working fine
     @current_folder = Folder.all.find(params[:folder_id])

     #then we make sure the folder we are creating has a parent folder which is the @current_folder
     @folder.parent_id = @current_folder.id
   end
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create

    @folder = Folder.new(folder_params)
    @folder.user_id = current_user.id
   if @folder.save
    flash[:notice] = "Successfully created folder."

    if @folder.parent #checking if we have a parent folder on this one
      redirect_to browse_path(@folder.parent)  #then we redirect to the parent folder
    else
      redirect_to root_url #if not, redirect back to home page
    end
   else
    render :action => 'new'
   end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    folder = @folder
    @folder.destroy
      if folder.parent
      redirect_to browse_path(folder.parent)
    else
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :parent_id, :user_id)
    end
end
