class Api::BlogsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    blogs = current_user.blogs
    render json: { data: blogs }
  end

  def create
    blog = current_user.blogs.build(blog_params)
    if blog.save
      render json: { data: blog }, status: :created
    else
      render json: { errors: blog.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    blog = get_blog
    if blog.nil?
      render json: { error: "Blog not found or you are not authorized to delete it." }, status: :not_found
      return
    end
    blog.destroy
    head :no_content
  end

  def show
    blog = get_blog
    if blog.nil?
      render json: { error: "Blog not found or you are not authorized to view it." }, status: :not_found
      return
    end
    render json: { data: blog }
  end

  def update
    blog = get_blog
    if blog.nil?
      render json: { error: "Blog not found or you are not authorized to update it." }, status: :not_found
      return
    end
    if blog.update(blog_params)
      render json: blog
    else
      render json: { errors: blog.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def get_blog
    current_user.blogs.find_by(id: params[:id])
  end
end
