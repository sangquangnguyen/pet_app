class Api::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    blog = get_current_user_blog
    if blog.nil?
      render json: { error: "Blog not found or you are not authorized to view it." }, status: :not_found
      return
    end
    render json: { data: blog.comments }
  end

  def show
    comment = get_comment
    if comment.nil?
      render json: { error: "Comment not found or you are not authorized to view it." }, status: :not_found
      return
    end
    render json: { data: comment }
  end

  def create
    comment = get_current_user_blog.comments.build(comment_params.merge(user_id: current_user.id))
    puts "comment: #{comment.to_json}"
    if comment.save
      render json: { data: comment }, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def get_current_user_blog
    current_user.blogs.find_by(id: params[:blog_id])
  end

  def get_comment
    blog = get_current_user_blog
    blog.comments.find_by(id: params[:id])
  end
end
