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