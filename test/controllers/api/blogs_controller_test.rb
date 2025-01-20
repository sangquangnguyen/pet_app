require 'rails_helper'

describe Api::BlogsControllerTest do
  let(:user) { create(:user) }
  let(:blog) { create(:blog, user: user) }

  describe 'GET #index' do
    it 'returns all blogs of the current user' do
      create(:blog, user: user)
      create(:blog, user: user)
      create(:blog, user: other_user) # Blog owned by another user

      get :index

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].size).to eq(2)
    end
  end
end
