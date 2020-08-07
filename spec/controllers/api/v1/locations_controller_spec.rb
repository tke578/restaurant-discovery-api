RSpec.describe Api::V1::LocationsController, type: :controller do
	describe "POST#search" do
		it "requires authentication" do
			post :search
			expect(response.status).to eq(401)
		end

		context "invalid params" do
			before(:each) do
				allow_any_instance_of(ApplicationController).to receive(:is_authorized).and_return(true)
			end
			it "returns 400 response" do
				controller.instance_variable_set(:@user, User.create(email: 'bob@yahoo.com', password: '123'))
				post :search	
				expect(response.status).to eq(400)
			end
		end
		context "valid params" do
			before(:each) do
				allow_any_instance_of(ApplicationController).to receive(:is_authorized).and_return(true)
			end
			it "returns 200 response" do
				controller.instance_variable_set(:@user, User.create(email: 'bob@yahoo.com', password: '123'))
				post :search, params: { radius: 150, address: "1201 Fulton st San Francisco 94117" }
				expect(response.status).to eq(200)
			end
		end
		context "response has search results" do
			before(:each) do
				allow_any_instance_of(ApplicationController).to receive(:is_authorized).and_return(true)
			end
			it "has a result identifier" do
				controller.instance_variable_set(:@user, User.create(email: 'bob@yahoo.com', password: '123'))
				post :search, params: { radius: 1, address: "1201 Fulton st San Francisco 94117" }
				expect(JSON.parse(response.body).keys).to include("results")
			end
		end
	end

	describe "POST#add_favorite" do
		before(:each) do
			allow_any_instance_of(ApplicationController).to receive(:is_authorized).and_return(true)
		end
		it "adds a favorite location" do
			controller.instance_variable_set(:@user, User.create(email: 'bob@yahoo.com', password: '123'))
			post :add_favorite, params: { location_id: '1234'}
			expect(response.body).to match(/Favorite location has been added./)
		end
		context "when favorite already exists" do
			it "returns a 400 response" do
				user = User.create(email: 'bob@yahoo.com', password: '123')
				loc = FavoriteLocation.create(user: user, location_id: '123')
				controller.instance_variable_set(:@user, user)
				post :add_favorite, params: { location_id: '123'}
				expect(response.status).to eq(400)
			end
		end
	end

	describe "DEL#remove_favorite" do
		before(:each) do
			allow_any_instance_of(ApplicationController).to receive(:is_authorized).and_return(true)
		end
		it "removes favorite location" do
			user = User.create(email: 'bob@yahoo.com', password: '123')
			loc = FavoriteLocation.create(user: user, location_id: '123')
			controller.instance_variable_set(:@user, user)
			delete :remove_favorite, params: { location_id: '123'}
			expect(JSON.parse(response.body)["msg"]).to match(/This location has been removed from your favorites./)
		end
		context "invalid location" do
			it "returns 400 response" do
				user = User.create(email: 'bob@yahoo.com', password: '123')
				controller.instance_variable_set(:@user, user)
				delete :remove_favorite, params: { location_id: '123'}
				expect(response.status).to eq(400)
			end
		end
	end

end