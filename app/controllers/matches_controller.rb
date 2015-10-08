class MatchesController < ApplicationController

	def show
    @potential_match = User.find_by(id: params[:id])
	end

  def create

  end

end