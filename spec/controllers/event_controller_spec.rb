require 'rails_helper'

RSpec.describe EventController, :type => :controller do
	describe "GET #index" do
		it "responds successfully with an HTTP 200 status code"
			get :index
			expect(response).to be_success
			expect(response).to have_htt_status(200) 
		end

		it "renders the index template" do
			get :index
			expect(response).to render_template("index")
		end
	end

end
