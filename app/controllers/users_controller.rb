class UsersController < ApplicationController
  def index
    @users=User.all

    respond_to do |format|
      format.html
      format.csv { send_data @users.export }
      format.xls
    end


  end

  def import
    User.import(params[:file].path)
    redirect_to users_index_path, notice: 'File Imported'
  end

end
