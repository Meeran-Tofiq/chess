require 'pieces.rb'

describe Pawn do
    describe "#move" do
        it "moves the pawn when passed a correct space for movement" do
            pawn = Pawn.new([0, 1])
            expect(pawn.move([0, 2])).to eq([0, 2])
        end

        it "returns false when the new destination given isn't available" do
            pawn = Pawn.new([7, 1])
            expect(pawn.move([0, 2])).to eq(false)
        end

        it "returns false when you try to move a pawn diagonally without taking" do
            pawn = Pawn.new([5, 1])
            expect(pawn.move([6,2])).to eq(false)
        end
    end
end