class AddressesController < ApplicationController
	def new
		@address = Address.new
	end

	def create
		@address = Address.new(address_params)
		@address.save
	end

	private
		def address_params
			params.require(:address).permit(:city, :country, :profile_id)
		end
end
