class HomeController < ApplicationController
  def root
    if user_signed_in?
      @image = Image.new
      @my_recently_uploaded = current_user.recently_uploaded
    end

    @recently_uploaded = Image.recently_uploaded(current_user)
  end
end
