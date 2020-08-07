RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET#index" do
    it "requires authentication" do
      get :index
      expect(response.status).to eq(401)
    end
  end

  describe "POST#create" do
    context "invalid params" do
      it "return 400 response" do
        post :create, params: { email: '', password: ''}
        expect(response.status).to eq(400)
      end
    end
    it "requires a email address & password" do
      post :create, params: { email: '', password: ''}
      expect(response.body).to match(/Password can't be blank,Email is invalid/)
    end
    context "valid params" do
      it "returns a 200 response" do
        post :create, params: { email: 'bob@yahoo.com', password: '1234'}
        expect(response.status).to eq(200)
      end
      it "returns a Authorization token" do
        post :create, params: { email: 'bob@yahoo.com', password: '1234'}
        expect(response.status).to eq(200)
      end
    end
  end

  describe "POST#login" do
    context "invalid params" do
      it "returns 400 response" do
        post :login, params: {}
        expect(response.status).to eq(400)
      end
    end

    context "valid params" do
      it "returns 200 response" do
        User.create(email: 'bob@yahoo.com', password: '123')
        post :login,  params: { email: 'bob@yahoo.com', password: '123'}
        expect(response.status).to eq(200)
      end
      it "returns the authentication token" do
        User.create(email: 'bob@yahoo.com', password: '123')
        post :login,  params: { email: 'bob@yahoo.com', password: '123'}
        expect(JSON.parse(response.body).keys).to include("token")
      end
    end
  end
end