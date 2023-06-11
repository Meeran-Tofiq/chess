require 'pieces.rb'
require 'player.rb'

describe Pawn do
    describe "#move" do
        it "creates a ghost tile right behind the pawn if you move it two spaces" do
            Board.reset
            pawn = Pawn.new([1, 4], "w")
            pawn.move([3,4])
            expect(pawn.ghost.pos).to eq([2,4])
        end

        it "doesn't create a ghost when you move a pawn once" do
            Board.reset
            pawn = Pawn.new([1, 4], "w")
            pawn.move([2,4])
            expect(pawn.ghost).to eq(nil)
        end
    end

    describe "#take" do
        it "removes the ghost and its pawn if you take the ghost using a pawn (i.e. en passant)" do
            Board.reset
            pawn = Pawn.new([1, 4], "w")
            pawn_take = Pawn.new([3, 3], "b")
            pawn.move([3, 4])
            pawn_take.reverse_pawn_direction
            pawn_take.take([2, 4])
            Board.print
            expect([Board.get_piece_at([2, 4]), Board.get_piece_at([3, 4])]).to eq([pawn_take, nil])
        end
    end
end