require 'player.rb'

describe Player do
    describe "#create_pieces" do
        it "Sets the board correctly for white" do
            player = Player.new()
            Board.print
            Board.reset
        end
    end
end