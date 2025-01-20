require 'rails_helper'

RSpec.describe Api::BlogsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:blog) { create(:blog, user: user) }

  # Generate JWT token for the user
  let(:jwt_token) { jwt_token_for(user) }

  # Include token in the request headers
  before do
    request.headers['Authorization'] = "Bearer #{jwt_token}"
  end

  describe 'GET #index' do
    it 'returns all blogs of the current user' do
      create(:blog, user: user)
      create(:blog, user: user)
      create(:blog, user: other_user) # Blog owned by another user

      get :index

      expect(response).to have_http_status(:success)
      puts response.body
      expect(JSON.parse(response.body)['data'].size).to eq(2)
    end
  end

  describe 'POST #create' do
    let(:params) { { blog: { title: 'New Blog', content: 'Blog content' } } }

    it 'creates a new blog with valid parameters' do
      expect {
        post :create, params: params
      }.to change(Blog, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['data']['title']).to eq('New Blog')
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the blog if it belongs to the current user' do
      delete :destroy, params: { id: blog.id }

      expect(response).to have_http_status(:no_content)
      expect(Blog.exists?(blog.id)).to be_falsey
    end

    it 'does not delete the blog if it does not belong to the current user' do
      other_blog = create(:blog, user: other_user)

      delete :destroy, params: { id: other_blog.id }

      expect(response).to have_http_status(:not_found)
      expect(Blog.exists?(other_blog.id)).to be_truthy
    end
  end

  describe 'GET #show' do
    it 'returns the blog if it belongs to the current user' do
      get :show, params: { id: blog.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data']['id']).to eq(blog.id)
    end

    it 'returns an error if the blog does not belong to the current user' do
      other_blog = create(:blog, user: other_user)

      get :show, params: { id: other_blog.id }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Blog not found or you are not authorized to view it.')
    end
  end

  describe 'PUT #update' do
    let(:params) { { id: blog.id, blog: { title: 'Updated Title', content: 'Updated content' } } }

    it 'updates the blog if it belongs to the current user and parameters are valid' do
      put :update, params: params

      expect(response).to have_http_status(:success)
      expect(blog.reload.title).to eq('Updated Title')
    end

    it 'does not update the blog if it does not belong to the current user' do
      other_blog = create(:blog, user: other_user)

      put :update, params: { id: other_blog.id, blog: { title: 'New Title' } }

      expect(response).to have_http_status(:not_found)
      expect(other_blog.reload.title).not_to eq('New Title')
    end
  end
end
