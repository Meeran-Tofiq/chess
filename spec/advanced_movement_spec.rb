require 'pieces.rb'


describe Pawn do
    describe "#move" do
        it "allows pawn to move 2 spaces, if it's its first move" do
            Board.reset_board
            p = Pawn.new([1, 0], "w")
            expect(p.move([3, 0])).to eq([3, 0])
        end

        it "doesn't allow pawn to move 2 spaces, after its first move" do
            p = Pawn.new([1,1], "w")
            p.move([2,1])
            expect(p.move([4, 1])).to eq(false)
            Board.reset_board
        end
    end
end

describe "#move" do
    it "won't let a bishop move past a piece" do
        b = Bishop.new([3, 3], "b")
        p = Pawn.new([4, 4], "w")
        Board.print
        expect(b.move([5, 5])).to eq(false)
    end

    it "won't let a rook move past a piece" do
        r = Rook.new([3, 4], "w")
        Board.print
        expect(r.move([5, 4])).to eq(false)
    end

    it "won't let the queen move past a piece" do
        q = Queen.new([4, 3], "b")
        Board.print
        expect(q.move([2, 5])).to eq(false)
        expect(q.move([2, 3])).to eq(false)
        expect(q.move([4, 5])).to eq(false)
        Board.reset_board
    end
end