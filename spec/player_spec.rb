require 'player.rb'

describe Player do
    describe "#create_pieces" do
        it "Sets the board correctly for white" do
            Board.reset
            player = Player.new()
            player_black = Player.new("b", false)
            Board.print
            Board.reset
        end
    end
end