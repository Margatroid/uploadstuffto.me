class UsersController < ApplicationController
  def show
    @user           = User.find_by_username(params[:username])
    @recent_uploads = @user.recently_uploaded_paginate(params[:page])
  end
end
