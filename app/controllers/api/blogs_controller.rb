class Api::BlogsController < ApplicationController
  before_action :authenticate_user!

  def index
    blogs = Blog.where(user_id: current_user.id)
    render json: blogs
  end
end
