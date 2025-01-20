require 'rails_helper'

RSpec.describe Api::CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:blog) { create(:blog, user: user) }
  let(:other_blog) { create(:blog, user: other_user) }
  let(:comment) { create(:comment, user: user, blog: blog) }

  # Generate JWT token for the user
  let(:jwt_token) { jwt_token_for(user) }

  # Include token in the request headers
  before do
    request.headers['Authorization'] = "Bearer #{jwt_token}"
  end

  describe 'GET #index' do
    it 'returns all comments for the blog when user is authorized' do
      create(:comment, blog: blog, user: user)
      create(:comment, blog: blog, user: user)

      get :index, params: { blog_id: blog.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].size).to eq(2)
    end
  end

  describe 'POST #create' do
    let(:params) { { blog_id: blog.id, comment: { content: 'New Comment' } } }

    it 'creates a comment with valid parameters' do
      expect {
        post :create, params: params
      }.to change(Comment, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['data']['content']).to eq('New Comment')
    end

    it 'returns not found when the blog does not belong to the user' do
      post :create, params: { blog_id: other_blog.id, comment: { content: 'Unauthorized comment' } }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Blog not found or you are not authorized to view it.')
    end
  end

  describe 'GET #show' do
    it 'returns the comment when user is authorized' do
      get :show, params: { blog_id: blog.id, id: comment.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data']['id']).to eq(comment.id)
    end

    it 'returns not found when the comment does not exist' do
      get :show, params: { blog_id: blog.id, id: 999 }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Comment not found or you are not authorized to view it.')
    end
  end
end