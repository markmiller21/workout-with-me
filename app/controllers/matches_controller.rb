class MatchesController < ApplicationController

	def new
    @potential_match = User.find_by(id: params[:id])
	end

end