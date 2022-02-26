require 'rails_helper'

RSpec.describe '/users', type: :request do

  let(:valid_attributes) do
    {
      'user_type' => 'user_type',
      'email' => 'test@example.com',
      'password' => "$2a$12$K0ByB.6YI2/OYrB4fQOYLe6Tv0datUVf6VZ/2Jzwm879BW5K1cHey",
      'password_confirmation' => "$2a$12$K0ByB.6YI2/OYrB4fQOYLe6Tv0datUVf6VZ/2Jzwm879BW5K1cHey"
    }
  end

  let(:invalid_attributes) do
    {
      'user_type' => 'user_type',
      'email' => 'test@example.com',
      'password' => "$2a$12$K0ByB.6YI2/OYrB4fQOYLe6Tv0datUVf6VZ/2Jzwm879BW5K1cHey",
      'password_confirmation' => "$2a$12$K0ByB.6YI2//2Jzwm879BW5K1cHey"
    }
  end

  describe 'GET/index' do
    it "renders a successful index response'" do
      test_user = User.new(valid_attributes)
      test_user.user_type = "user_type"
      test_user.save
      get users_url
      assert_response :found
    end
  end

  describe 'GET /signup' do
    it 'renders a successful show response' do
      test_user = User.new(valid_attributes)
      test_user.user_type = "user_type"
      test_user.save
      get signup_url(test_user)
      assert_response :ok
    end
  end

  describe 'GET /show' do
    it 'renders a successful show response' do
      test_user = User.new(valid_attributes)
      test_user.user_type = "user_type"
      test_user.save
      get user_url(test_user)
      assert_response :found
    end
  end

  describe 'GET /new' do
    it 'renders a successful new response' do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful edit response' do
      test_user = User.new(valid_attributes)
      test_user.user_type = "user_type"
      test_user.save
      get edit_user_url(test_user)
      assert_response :found
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          user = User.new(valid_attributes)
          user.user_type = 'user_type'
          user.save
          post users_url, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post users_url, params: { user: valid_attributes }
        assert_response :found
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post users_url, params: { user: invalid_attributes }
        end.to change(User, :count).by(0)
      end

      it "renders a response with errors" do
        post users_url, params: { user: invalid_attributes }
        assert_response :unprocessable_entity
      end
    end
  end

end