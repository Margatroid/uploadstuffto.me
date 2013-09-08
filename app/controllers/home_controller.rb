class HomeController < ApplicationController
  def root
    @image = Image.new if user_signed_in?
  end
end
