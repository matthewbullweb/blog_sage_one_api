class SageController < ApplicationController
  def index
  
	# The code below is over-simplified. Read Sage's own API docs and the documentation for SageOne::Oauth to get
	# a better idea of how to implement this in the context of your own app.
	SageOne.configure do |c|
	  c.client_id     = "ade7e7f155085734a3f6"
	  c.client_secret = "4b13382abfbaf56b5b9e3397b3d8c1718143ee3a"
	end

	# Redirect the current user to SageOne. This will give them the choice to link SageOne with your app.
	# and subsequently redirect them back to your callback_url with an authorisation_code if they choose to do so.
	redirect_to SageOne.authorize_url('https://localhost:3000/sage')

	# Then, in the callback URL controller, run get_access_token, i.e.
	response = SageOne.get_access_token(params[:code], 'https://localhost:3000/sage')
	User.save_access_token(response.access_token) unless response.access_token.nil?

  end
end
