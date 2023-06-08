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

    describe "#get_pieces_with_des" do
        it "Returns all the pieces that can move to the provided destination" do
            Board.reset
            player = Player.new()
            Board.print
            expect(player.get_pieces_with_des([2, 2], :N, false)[0]).to eq(player.pieces[:N][0])
        end
    end
end