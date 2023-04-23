require 'pieces.rb'


describe Pawn do
    describe "#move" do
        it "allows pawn to move 2 spaces, if it's its first move" do
            Board.reset_board
            p = Pawn.new([0, 1], "w")
            expect(p.move([0, 3])).to eq([0, 3])
        end

        it "doesn't allow pawn to move 2 spaces, after its first move" do
            p = Pawn.new([1,1], "w")
            p.move([1,2])
            expect(p.move([1, 4])).to eq(false)
            Board.reset_board
        end
    end
end