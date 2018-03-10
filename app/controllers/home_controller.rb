class HomeController < ApplicationController

	def show
		@omit_header = true
		@omit_footer = true
		store_location
	end

end
