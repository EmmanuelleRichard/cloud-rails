class HomeController < ApplicationController
  def index
    if user_signed_in?
      #load current_user's folders
      @folders = Folder.all.where("parent_id is NULL")
      #load current_user's files(assets)
      @archives = Archive.all.where("folder_id is NULL")

    end
end
def browse
    #get the folders owned/created by the current_user
    @current_folder = Folder.all.find(params[:folder_id])

    if @current_folder

      #getting the folders which are inside this @current_folder
      @folders = @current_folder.children

      #We need to fix this to show files under a specific folder if we are viewing that folder
      @archives = @current_folder.archives.order("uploaded_file_file_name desc")

      render :action => "index"
    else
      flash[:error] = "Don't be cheeky! Mind your own folders!"
      redirect_to root_url
    end
end
end
