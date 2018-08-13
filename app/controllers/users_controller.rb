class UsersController < ApplicationController
  def index
    @users=User.all
  end

  def import
    User.import(params[:file].path)
    redirect_to users_index_path, notice: 'File Imported'
  end
end
