require 'pieces.rb'
require 'board.rb'

describe "#take" do
    describe Pawn do
        it "lets pawns take diagonally" do
            Board.reset
            pawn = Pawn.new([3, 4], "w")
            knight = Knight.new([4, 5], "b")
            expect(pawn.take([4, 5])).to eq(true)
        end

        it "doesn't let pawns take in front of them" do
            Board.reset
            pawn = Pawn.new([3, 4], "w")
            knight = Knight.new([4, 4], "b")
            expect(pawn.take([4, 4])).to eq(false)
        end
    end

    describe Knight do
        it "allows knights to take in their usual shape" do
            Board.reset
            knight = Knight.new([2, 2], "w")
            bishop = Bishop.new([1, 0], "b")
            expect(knight.take(bishop.pos)).to eq(true)
        end
    end

    describe King do
        it "allows the king to take as well" do
            Board.reset
            king = King.new([1, 1], "b")
            pawn = Pawn.new([1, 2], "w")
            expect(king.take(pawn.pos)).to eq(true)
        end
    end

    describe Bishop do
        it "allows the bishop to take as well" do
            Board.reset
            bishop = Bishop.new([1, 1], "b")
            pawn = Pawn.new([2, 2], "w")
            expect(bishop.take(pawn.pos)).to eq(true)
        end
    end

    describe Queen do
        it "allows the queen to take diagonally" do
            Board.reset
            queen = Queen.new([1, 1], "b")
            pawn = Pawn.new([2, 2], "w")
            expect(queen.take(pawn.pos)).to eq(true)
        end

        it "allows the queen to take straight" do
            Board.reset
            queen = Queen.new([1, 1], "b")
            pawn = Pawn.new([2, 1], "w")
            expect(queen.take(pawn.pos)).to eq(true)
        end
    end

    describe Rook do
        it "allows the rook to take diagonally" do
            Board.reset
            rook = Rook.new([1, 1], "b")
            pawn = Pawn.new([2, 1], "w")
            expect(rook.take(pawn.pos)).to eq(true)
        end
    end

    it "won't let same coloured pieces to take each other" do
        Board.reset
        queen = Queen.new([4, 4], "w")
        bishop = Bishop.new([5, 5], "w")
        expect(queen.take(bishop.pos)).to eq(false)
    end
end