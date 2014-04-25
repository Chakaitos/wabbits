module RabbitDice
  module Databases
    class InMemory

      def initialize
        @game_id_counter = 100
        @games = {}
      end

      def create_game(attrs)
        game = Game.new(:players => attrs[:players], :dice_cup => DiceCup.new)
        game.id = (@game_id_counter += 1)
        @games[game.id] = game

        starting_player = game.players.sample
        starting_turn = Turn.new(:game_id => game.id, :player => starting_player)
        game.turns.push(starting_turn)
        game
      end

      def get_game(id)
        # Since everything is in one object, this might be really messy later when we add persistence
        # Or, if we choose the right database (*cough* document-oriented database *cough*) it might not!
        # (A document-oriented database might be the right choice *for this project* because there is no
        # more than one user playing the game at one time)
        @games[id]
      end

    end
  end
end