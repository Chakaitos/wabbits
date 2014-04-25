class GamesController < ApplicationController
	def new
		# @game = RabbitDice.Game.new
		@players = []
	end

	def create
		players = params[:players]
		players.each do |player|
			if player == ""
				players.delete(player)
			end
		end
		@result = RabbitDice::CreateGame.run(:players => players)
		
		if @result.success?
			flash[:success] = "New Game Created"
			redirect_to "/games/#{@result.game.id}"
		else
			@error = "#{@result.error}"
			# @game =
			@players = players
			render 'new'
		end
	end

	def show
		flash[:success]
		@game = RabbitDice.db.get_game(params[:id].to_i)
		@players = @game.players
		@last_move = @game.turns.last
	end

	def update
		current_move = params[:move]
		id = params[:id].to_i
		@move = RabbitDice::PlayMove.run(:game_id => id, :move => current_move)
		redirect_to "/games/#{@move.game.id}"
	end
end
